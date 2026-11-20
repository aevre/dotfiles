import { existsSync, readFileSync, realpathSync } from "node:fs";
import { isAbsolute, join, relative, sep } from "node:path";
import { getAgentDir, type ExtensionAPI } from "@earendil-works/pi-coding-agent";

const rulesDir = join(getAgentDir(), "project-agents");
const projectsFile = join(rulesDir, "projects.json");

function isInside(root: string, cwd: string): boolean {
	const path = relative(root, cwd);
	return path === "" || (!isAbsolute(path) && path !== ".." && !path.startsWith(`..${sep}`));
}

function loadRules(cwd: string): string | undefined {
	if (!existsSync(projectsFile)) return;

	const projects = JSON.parse(readFileSync(projectsFile, "utf8")) as Record<string, string>;
	const realCwd = realpathSync(cwd);
	const match = Object.entries(projects)
		.filter(([root]) => existsSync(root))
		.map(([root, file]) => [realpathSync(root), file] as const)
		.filter(([root]) => isInside(root, realCwd))
		.sort(([a], [b]) => b.length - a.length)[0];
	if (!match) return;

	const base = readFileSync(join(rulesDir, "base.md"), "utf8").trim();
	const project = readFileSync(join(rulesDir, match[1]), "utf8").trim();
	return `# Project rule precedence

Apply the repository-specific rules below before the shared Neovim plugin rules when they conflict. Both scopes override conflicting global AGENTS.md instructions. Preserve all compatible broader rules.

<shared_neovim_plugin_rules>
${base}
</shared_neovim_plugin_rules>

<repository_specific_rules>
${project}
</repository_specific_rules>`;
}

export default function projectAgents(pi: ExtensionAPI) {
	pi.on("before_agent_start", (event, ctx) => {
		try {
			const rules = loadRules(ctx.cwd);
			if (rules) event.systemPromptOptions.sections.project_agents = rules;
			else delete event.systemPromptOptions.sections.project_agents;
		} catch (error) {
			delete event.systemPromptOptions.sections.project_agents;
			ctx.ui.notify(`Failed to load project agent rules: ${String(error)}`, "warning");
		}
	});
}

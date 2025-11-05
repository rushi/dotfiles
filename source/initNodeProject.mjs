#!/usr/bin/env zx --quiet

const dependencies = ["axios", "lodash-es", "chalk", "config", "dayjs", "prettyoutput", "js-yaml"];
const devDependencies = ["@types/node", "@types/config", "@types/lodash-es", "prettier"];
const extraDependencies = ["vite", "tailwindcss @tailwindcss/vite @vitejs/plugin-react tailwind-merge clsx"]; // Multiple in a single string means all together
const extraDevDependencies = ["prettier-plugin-tailwindcss"];

const cmd = (c) => c?.toString().trim() ?? null;

const prettier = {
    semi: true,
    printWidth: 120,
    trailingComma: "all",
    singleQuote: false,
    bracketSpacing: true,
    useTabs: false,
    arrowParens: "always",
    bracketSameLine: false,
    tabWidth: 4,
    plugins: [],
};

const editorConfig = `
# EditorConfig: https://EditorConfig.org

# top-most EditorConfig file
root = true

# Unix-style newlines with a newline ending every file
[*]
indent_style = space
indent_size = 4
end_of_line = lf
insert_final_newline = true

[*.{yml,yaml}]
indent_style = space
indent_size = 2

[*.{toml}]
indent_style = space
indent_size = 2
`;

const initNpmProject = async () => {
    if (fs.existsSync("package.json") || fs.existsSync("package-lock.json") || fs.existsSync("node_modules")) {
        // Read the name of the existing app and the existing directory
        const existingName = fs.existsSync("package.json") ? (await fs.readJson("./package.json")).name : null;
        console.log(chalk.red(`Warning this folder has existing data. App: '${existingName}'`));
        const proceed = await question(`Should I proceed? [y/n/remove] `);
        if (proceed.includes("remove")) {
            console.log(chalk.yellow("Removing existing package.json, package-lock.json, and node_modules..."));
            await $`rm -rf package.json package-lock.json node_modules`;
        } else if (!proceed.includes("y")) {
            console.log(chalk.red("Exiting without changes."));
            process.exit(0);
        } else {
            console.log(chalk.yellow("Proceeding with existing files, but this may cause issues."));
        }
        console.log();
    }

    console.log(chalk.blue("Initializing a new Node.js project with Node v20"));
    await fs.writeFileSync(".nvmrc", "v20");
    await $`fnm use`;

    const nodeVersion = cmd(await $`node -v`).slice(0, 3);
    console.log(`Node: ${chalk.green(nodeVersion)}`);

    const name = await question(`Project name: `);
    const typescript = await question(`Is this a typescript project? [y/n] `);
    const isTypescript = typescript.includes("y");
    if (isTypescript) {
        devDependencies.push("typescript", "type-fest");
    }

    await $`npm init -y`
    await $`npm pkg set type=module`;

    console.log(`Installing dependencies ${dependencies.map(p => chalk.bold(p)).join(", ")}`);
    await $`npm install ${dependencies}`;

    console.log(`Installing devDependencies ${devDependencies.map(p => chalk.bold(p)).join(", ")}`);
    await $`npm install --save-dev ${devDependencies}`;

    const main = isTypescript ? "app.ts" : "app.js";
    await $`touch ${main}`;
    console.log(`Created main file: ${chalk.bold(main)}`);

    let pkg = { ...(await fs.readJson("./package.json")), prettier };
    pkg = await handleExtraPackages(pkg, extraDependencies, false);
    pkg = await handleExtraPackages(pkg, extraDevDependencies, true);
    pkg = {
        ...(await fs.readJson("./package.json")), // This will contain the new dependencies installed above
        name,
        description: "TBD",
        main,
        prettier,
        private: true,
        engines: { node: `>=${nodeVersion.replace("v", "")}` },
    }

    await fs.writeFileSync("./package.json", JSON.stringify(pkg, null, 2));
    console.log("\n✅ All done, here is your package.json");
    echo(await $`npx prettyoutput package.json`);

    await fs.writeFileSync(".editorconfig", editorConfig);
};

const handleExtraPackages = async (pkg, extras, isDev = false) => {
    console.log(`\nThere are some extra ${isDev ? "devDependencies" : "dependencies"} you can install`, chalk.bold(extras));
    for (const extra of extras) {
        const install = await question(`Install ${chalk.green(extra + "?")} [y/n] `);
        if (install.includes("y")) {
            console.log(` Installing ${chalk.bold(extra)}...`);
            await $`npm install ${isDev ? "--save-dev" : "--save"} ${extra.split(" ")}`;
            if (extra.includes("vite") && !isDev) {
                pkg.scripts.start = "vite";
                pkg.scripts.build = "vite build";
                pkg.scripts.dev = "vite";
            }
            if (extra.includes("prettier-plugin-tailwindcss")) {
                pkg.prettier.plugins = ["prettier-plugin-tailwindcss"];
            }
        }
    }

    return pkg;
};

initNpmProject();

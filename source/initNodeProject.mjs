#!/usr/bin/env zx --quiet

const dependencies = ["axios", "lodash", "picocolors", "config", "dayjs", "prettyoutput", "toml"];
const devDependencies = ["@types/node", "@types/config", "@types/lodash", "prettier"];
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
    if (fs.existsSync("package.json") || fs.existsSync("node_modules")) {
        console.log(chalk.red("Warning package.json or node_modules already exists in this dir\n"));
    }

    const nodeVersion = cmd(await $`node -v`).slice(0, 3);
    console.log(`Node: ${chalk.green(nodeVersion)}`);

    const name = await question(`Project name: `);
    const typescript = await question(`Is this a typescript project? [y/n] `);
    const isTypescript = typescript.includes("y");
    if (isTypescript) {
        devDependencies.push("typescript", "type-fest");
    }

    await $`npm init -y`;

    console.log(`Installing dependencies ${dependencies.join(", ")}`);
    await $`npm install ${dependencies}`;

    console.log(`Installing devDependencies ${devDependencies.join(", ")}`);
    await $`npm install --save-dev ${devDependencies}`;

    const main = isTypescript ? "app.ts" : "app.js";
    const pkg = {
        ...(await fs.readJson("./package.json")),
        name,
        main,
        scripts: {},
        private: true,
        engines: { node: `>=${nodeVersion.replace("v", "")}` },
        prettier,
    };

    await fs.writeFileSync("./package.json", JSON.stringify(pkg, null, 2));
    console.log(chalk.green("\nAll done, here is your package.json"));
    echo(await $`npx prettyoutput package.json`);

    await fs.writeFileSync(".editorconfig", editorConfig);
};

initNpmProject();

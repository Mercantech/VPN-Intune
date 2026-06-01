# GitHub Actions i dette repo

Vi har én workflow: **PowerShell lint** (`powershell-lint.yml`).

## Hvornår kører den?

Workflowen startes automatisk når der pushes eller oprettes en **pull request**, og ændringerne berører mindst én af disse filtyper/stier:

| Trigger | Stier |
|---------|--------|
| `pull_request` | `**/*.ps1`, `**/*.psd1`, workflow-filen selv |
| `push` | Samme som ovenfor |

Ændringer kun i README, billeder eller MSI-filer i `Files/` starter **ikke** workflowen.

## Hvad gør den?

1. **Checkout** – henter repo-koden på en Windows-runner (`windows-latest`).
2. **Install PSScriptAnalyzer** – installerer [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer) fra PowerShell Gallery.
3. **Analyze deployment script** – kører analysen på `Invoke-AppDeployToolkit.ps1` med severity **Error** (advarsler alene stopper ikke buildet).
4. **Analyze examples** – samme tjek på alle `.ps1` og `.psd1` under `examples/` (fx demo-filer til undervisning).

Hvis der findes fejl, udskrives de og jobbet afsluttes med **exit code 1** → workflowen markeres som fejlet på GitHub.

## Hvorfor har vi den?

| OneDrive / manuel deling | Med denne Action |
|--------------------------|------------------|
| Ingen automatisk tjek af PowerShell før udrulning | Fejl i scripts opdages ved PR/push |
| Svært at vide om en ændring "er valid" | Grønt/rødt tjek på GitHub under Checks |
| Samme mappe – sidste fil vinder | Ændringer kan kræves gennem PR + review |

Workflowen er en del af undervisningsmaterialet om **Git vs. OneDrive** (commit #9 i [commit-oversigt.md](../../docs/undervisning/commit-oversigt.md)).

## Hvor ser man resultatet?

- **Pull request:** fanen *Checks* / *Actions* på PR'en.
- **Push til `main`:** *Actions* i repoet på GitHub → workflow *PowerShell lint*.

## Konfiguration og udvidelse

- Workflow-fil: [powershell-lint.yml](powershell-lint.yml)
- Kun **Error**-niveau fejler buildet; for at inkludere advarsler, udvid `-Severity` i scriptet.
- Med **branch protection** kan I kræve, at dette tjek består før merge til `main`.

## Begrænsninger

- Analyserer **ikke** hele `PSAppDeployToolkit/`-modulet (kun deployment-scriptet og `examples/`).
- Kører **ikke** installation, Intune-pakning eller test mod rigtig FortiClient-MSI.
- Store filer i `Files/` (*.msi, *.exe) er uden for scope – de er bevidst udelukket fra Git via `.gitignore`.

# Commit-oversigt – Git vs. OneDrive

Denne tabel matcher de **9 demo-commits** i repo-historikken. Brug den som manuskript under undervisning.

| # | Commit-besked | OneDrive-problem | Git-gevinst |
|---|---------------|------------------|-------------|
| 1 | `docs(undervisning): tilføj lab og commit-oversigt` | Kaotiske mapper med `_FINAL_v2` | Struktureret `docs/undervisning/` |
| 2 | `feat(demo): tilføj fiktiv deployment-config til lab` | `config (1).psd1` ved konflikt | Én fil, én sand kilde |
| 3 | `fix(demo): ret VPN-port fra 443 til 10443 i demo-config` | "Hvem rettede porten?" | `git show` + forfatter + besked |
| 4 | `docs(demo): beskriv OneDrive-filnavns-kaos` | `script_FINAL_brug_denne.ps1` | Historik i stedet for kopier |
| 5 | `chore: tilføj CHANGELOG for demo-ændringer` | Ingen release-noter | `CHANGELOG.md` ved udgivelser |
| 6 | `docs: forklar at MSI/EXE holdes uden for repo` | 500 MB MSI synkes til alle | `.gitignore` + separat distribution |
| 7 | `docs(config): tydeliggør skabelon vs. rigtig kundefil i Git` | Følsom VPN-adresse i delt mappe | Kun skabelon i Git |
| 8 | `docs(undervisning): tilføj "se historik"-guide til underviser` | — | Konkrete `git`-kommandoer |
| 9 | `ci: kør PSScriptAnalyzer på PowerShell ved pull request` | Ingen automatisk tjek | GitHub Actions på PR |

---

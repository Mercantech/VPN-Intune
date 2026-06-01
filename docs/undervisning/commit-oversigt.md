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

## Guide til underviseren – kommandoer pr. commit

Kør fra repo-roden. Erstat `<hash>` med den korte hash fra `git log --oneline`.

### Overblik

```powershell
git log --oneline --graph -15
```

### Commit 1 – struktur frem for filnavns-kaos

```powershell
git show <hash-commit-1> --stat
```

Peg på at alt ligger under `docs/undervisning/` i stedet for spredte `_FINAL`-kopier.

### Commit 2 og 3 – én fil, fuld historik (port-ændring)

Find commit #3 (port-rettelse):

```powershell
git log --oneline -- examples/git-demo/DeploySettings.psd1
git show <hash-commit-3>
```

Sammenlign med forrige version:

```powershell
git diff <hash-commit-2> <hash-commit-3> -- examples/git-demo/DeploySettings.psd1
```

**Budskab:** OneDrive gemmer "fil opdateret kl. 14:32". Git gemmer *hvad* (443 → 10443), *hvem* og *hvorfor* (commit-beskeden).

### Commit 4 – OneDrive-filnavne

```powershell
git show <hash-commit-4> -- examples/git-demo/onedrive-kaos.md
```

### Commit 5 – release-noter

```powershell
git show <hash-commit-5> -- CHANGELOG.md
```

Sammenlign med at manuelt vedligeholde `version_FINAL.txt` i en sky-mappe.

### Commit 6 – binære filer udenfor repo

```powershell
git show <hash-commit-6> -- Files/
cat .gitignore | Select-String -Pattern 'Files'
```

Vis at `git status` ignorerer en MSI, hvis du lægger en i `Files/` (demo live).

### Commit 7 – hemmeligheder og skabelon

```powershell
git show <hash-commit-7> -- Config/CustomerSettings.Example.psd1
git check-ignore -v Config/CustomerSettings.psd1
```

Forklar: rigtige kundeværdier i `CustomerSettings.psd1` committes aldrig.

### Commit 8 – denne guide

```powershell
git show <hash-commit-8> -- docs/undervisning/commit-oversigt.md
```

### Commit 9 – automatisk tjek på PR

Vis `.github/workflows/powershell-lint.yml` på GitHub under Actions, eller lokalt:

```powershell
git show <hash-commit-9> -- .github/workflows/powershell-lint.yml
```

**Budskab:** Ingen PowerShell-lint i OneDrive – fejl opdages først ved udrulning.

### Valgfrit: tag som "testet udgave"

```powershell
git tag v-demo-1.0 <hash-commit-5-eller-9>
git log --oneline --decorate -5
```

Sammenlign med `FortiClient_v2_FINAL_brug_denne.ps1`.

---

## Hurtig demo-rækkefølge (15 min)

1. `git log --oneline --graph`
2. `git show` på commit #3 (port)
3. `git diff` mellem #2 og #3
4. `git check-ignore` på `CustomerSettings.psd1`
5. Vis GitHub Actions / workflow-fil for commit #9

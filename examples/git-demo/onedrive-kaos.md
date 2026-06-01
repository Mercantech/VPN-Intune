# OneDrive-filnavns-kaos (det vi vil væk fra)

Når flere redigerer samme mappe i OneDrive, ender man ofte med kopier i stedet for en fælles historik:

```
FortiClient_v1.ps1
FortiClient_v2.ps1
FortiClient_v2_FINAL.ps1
FortiClient_v2_FINAL_rettet.ps1
FortiClient_v2_FINAL_brug_denne.ps1
Invoke-AppDeployToolkit-MATHIAS-PC.ps1
Invoke-AppDeployToolkit (konflikt ved 2026-05-29 14-32).ps1
```

## Problemet

| OneDrive | Git |
|----------|-----|
| Ingen ved hvilken fil der er "sand" | `main` + tags markerer udgivelser |
| Ingen forklaring på ændringer | Hver commit har besked + forfatter |
| Konflikt = ny fil | Konflikt løses bevidst ved merge |
| Svært at sammenligne versioner | `git diff` linje for linje |

## I dette repo

`.gitignore` ignorerer allerede typiske OneDrive-konfliktkopier (`*-*PC*.ps1`, `* (konflikt*).*`).

I stedet for flere filnavne har vi **én** `examples/git-demo/DeploySettings.psd1` med fuld historik – se commit #3 i [commit-oversigt.md](../../docs/undervisning/commit-oversigt.md).

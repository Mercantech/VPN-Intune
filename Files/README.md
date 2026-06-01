# Installationskilder (Files/)

Denne mappe er til **binære installationsfiler** – ikke til scripts eller konfiguration i Git.

## Hvad skal ligge her?

| Fil | Formål |
|-----|--------|
| `FortiClientVPN7.4.3.8758.msi` | Hovedinstallation |
| `hotfix.exe` | Hotfix hvis 7.4.3 allerede er installeret |

## Hvorfor er de ikke i Git?

Git er bygget til **tekst** (scripts, `.psd1`, dokumentation). Store MSI/EXE-filer:

- Gør repoet tungt at clone
- Kan ikke meningsfuldt sammenlignes (`git diff` viser ikke "hvad ændredes")
- Hører typisk til **Intune-pakke**, **GitHub Release** eller intern fildeling – ikke versionsstyring af logikken

`.gitignore` udelukker `Files/*.msi`, `Files/*.exe` osv., men bevarer denne README og `Add Setup Files Here.txt`.

## OneDrive vs. Git

I en OneDrive-delt mappe synkroniseres MSI'en til alle maskiner – også dem der kun skal redigere et script.

Med Git versionsstyrer vi **logikken** i repoet og henter binære kilder separat ved build/udrulning.

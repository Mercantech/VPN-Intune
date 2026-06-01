# FortiClient VPN

Deployment-pakke til **Fortinet FortiClient VPN 7.4.3.8758**, bygget med [PSAppDeployToolkit (PSADT) v4](https://psappdeploytoolkit.com). Pakken installerer FortiClient VPN, konfigurerer automatisk en SSL-VPN-tunnel til kundens netværk, og er beregnet til udrulning via Microsoft Intune, SCCM/MECM eller en anden software-distributionsløsning.

> **Bemærk:** Kundespecifikke værdier (VPN-navn, beskrivelse og serveradresse) ligger i `Config\CustomerSettings.psd1`, som holdes **uden for Git**. Kopiér `Config\CustomerSettings.Example.psd1` til `Config\CustomerSettings.psd1` og udfyld de rigtige værdier før udrulning.

## Undervisning: Git vs. OneDrive

Repoet indeholder forberedt demomateriale til at vise fordele ved Git frem for OneDrive-synk. Start her:

- [docs/undervisning/](docs/undervisning/) – lab og commit-oversigt til sessionen
- [docs/Fra-OneDrive-til-Git.md](docs/Fra-OneDrive-til-Git.md) – fuld teori og arbejdsgang

---

## Indhold

- [Oversigt](#oversigt)
- [Hvad pakken gør](#hvad-pakken-gør)
- [Krav](#krav)
- [Mappestruktur](#mappestruktur)
- [Brug](#brug)
- [Detection / registrering](#detection--registrering)
- [Konfiguration](#konfiguration)
- [Logning](#logning)
- [Exit-koder](#exit-koder)

---

## Oversigt

| Egenskab | Værdi |
|----------|-------|
| Producent (AppVendor) | Fortinet |
| Applikation (AppName) | FortiClient VPN |
| Version (AppVersion) | 7.4.3.8758 |
| Sprog | EN |
| Revision | 01 |
| Kræver administrator | Ja |
| PSADT-version | 4.1.7 |
| Script-version | 1.0.0 |
| Forfatter | netIP – PMK |

---

## Hvad pakken gør

### Installation
1. Viser en velkomstdialog (op til 3 udskydelser tilladt, tjekker diskplads).
2. Tjekker registreringsdatabasen for en eksisterende FortiClient-installation:
   - Hvis version `7.4.3.*` allerede er installeret, køres `hotfix.exe -q`.
   - Ellers installeres `FortiClientVPN7.4.3.8758.msi` stille (`/quiet /norestart`).
3. **Post-install** opretter automatisk en SSL-VPN-tunnel i registreringsdatabasen, hvis den ikke allerede findes. Værdierne læses fra `Config\CustomerSettings.psd1`:

   | Indstilling | Kilde |
   |-------------|-------|
   | Navn | `VpnName` |
   | Beskrivelse | `VpnDescription` |
   | Server | `VpnServer` |
   | Single Sign-On | Aktiveret (`sso_enabled = 1`) |

   Tunnellen skrives til `HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\<VpnName>`.
4. Skriver en detection-nøgle til `HKLM:\SOFTWARE\netIP\FortiClient VPN` med den installerede version.

### Afinstallation
1. Finder FortiClient i registreringsdatabasen og afinstallerer via `msiexec /x <ProductCode> /qn /norestart REBOOT=ReallySuppress`.
2. Fjerner detection-nøglen under `HKLM:\SOFTWARE\netIP\FortiClient VPN`.

### Reparation
Standard PSADT-reparationsflow (ingen tilpassede trin tilføjet).

---

## Krav

- Windows 10/11 (x64).
- Administratorrettigheder (`RequireAdmin = $true`).
- Windows PowerShell 5.1 eller PowerShell 7+.
- Installationsfilerne skal lægges i `Files\`-mappen (se nedenfor).

> **Vigtigt:** Mappen `Files\` skal indeholde `FortiClientVPN7.4.3.8758.msi` og `hotfix.exe` for at pakken virker. Disse binære filer er typisk ikke checket ind i repoet.

---

## Mappestruktur

```
FortiClient/
├─ Invoke-AppDeployToolkit.ps1      # Hovedscript (install/uninstall/repair)
├─ Config/
│  ├─ config.psd1                   # Toolkit-konfiguration (UI, logning, MSI-params)
│  ├─ CustomerSettings.Example.psd1 # Skabelon til kundespecifikke værdier (i Git)
│  └─ CustomerSettings.psd1         # Rigtige kundeværdier (IKKE i Git)
├─ Assets/
│  ├─ AppIcon.png                   # Logo til dialoger
│  └─ Banner.Classic.png            # Banner (Classic UI)
├─ Files/                           # Installationskilder (MSI + hotfix lægges her)
│  ├─ FortiClientVPN7.4.3.8758.msi
│  └─ hotfix.exe
├─ Strings/                         # Lokaliserede tekststrenge
├─ PSAppDeployToolkit/              # PSADT v4-modulet
└─ PSAppDeployToolkit.Extensions/   # Tilpassede PSADT-udvidelser
```

---

## Brug

Kør altid fra pakkens rodmappe.

**Installation (anbefalet til udrulning – stille):**

```powershell
powershell.exe -ExecutionPolicy Bypass -File .\Invoke-AppDeployToolkit.ps1 -DeploymentType Install -DeployMode Silent
```

**Installation (interaktiv med dialoger):**

```powershell
powershell.exe -ExecutionPolicy Bypass -File .\Invoke-AppDeployToolkit.ps1 -DeploymentType Install -DeployMode Interactive
```

**Afinstallation:**

```powershell
powershell.exe -ExecutionPolicy Bypass -File .\Invoke-AppDeployToolkit.ps1 -DeploymentType Uninstall -DeployMode Silent
```

**Reparation:**

```powershell
powershell.exe -ExecutionPolicy Bypass -File .\Invoke-AppDeployToolkit.ps1 -DeploymentType Repair
```

### Intune (Win32-app)

| Felt | Værdi |
|------|-------|
| Install-kommando | `powershell.exe -ExecutionPolicy Bypass -File Invoke-AppDeployToolkit.ps1 -DeploymentType Install -DeployMode Silent` |
| Uninstall-kommando | `powershell.exe -ExecutionPolicy Bypass -File Invoke-AppDeployToolkit.ps1 -DeploymentType Uninstall -DeployMode Silent` |
| Installationskontekst | System |

---

## Detection / registrering

Brug følgende til at registrere en vellykket installation (fx i Intune):

- **Registreringsnøgle:** `HKEY_LOCAL_MACHINE\SOFTWARE\netIP\FortiClient VPN`
- **Værdinavn:** `Installed`
- **Værditype:** String
- **Værdi:** `7.4.3.8758`

---

## Konfiguration

Generelle indstillinger styres i `Config\config.psd1`, bl.a.:

- **UI:** `DialogStyle = 'Fluent'`, balloon-notifikationer, timeouts.
- **MSI:** stille-/install-/uninstall-parametre (`REBOOT=ReallySuppress /QN`).
- **Toolkit:** cache-sti, log-stier og log-stil (CMTrace).

VPN-tunnellens parametre (navn, beskrivelse, server) ligger i `Config\CustomerSettings.psd1` og læses af `Invoke-AppDeployToolkit.ps1` i **Post-Install**-sektionen. Denne fil holdes uden for Git – brug `Config\CustomerSettings.Example.psd1` som skabelon.

---

## Logning

Logfiler skrives som standard til (CMTrace-format):

- Med admin: `%WinDir%\Logs\Software`
- Uden admin: `%ProgramData%\Logs\Software`

Op til 10 historiske logfiler beholdes (maks. 10 MB pr. fil).

---

## Exit-koder

| Kode | Betydning |
|------|-----------|
| 0 | Succes |
| 1641 / 3010 | Succes, genstart kræves |
| 1602 | Brugeren udskød/annullerede |
| 1618 | Dialog-timeout |
| 60001 | Uhåndteret fejl under deployment |
| 60008 | Fejl ved import af PSADT-modul / oprettelse af session |

---

*Bygget med PSAppDeployToolkit v4.1.7 · netIP – PMK*

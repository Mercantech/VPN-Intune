@{
    # ============================================================
    # Kundespecifik konfiguration (skabelon)
    # ============================================================
    # Denne fil er en SKABELON og indeholder kun pladsholdere.
    #
    # Sådan bruges den:
    #   1. Kopiér denne fil til 'CustomerSettings.psd1' i samme mappe.
    #   2. Udfyld med kundens rigtige værdier.
    #   3. 'CustomerSettings.psd1' er udelukket fra Git via .gitignore,
    #      så følsomme værdier havner aldrig i versionsstyringen.
    #
    # Git vs. OneDrive:
    #   - I Git: kun denne SKABELON committes (pladsholdere).
    #   - Lokalt: den rigtige fil med vpn.kunde.dk:443 ligger kun på din maskine.
    #   - I OneDrive: hele mappen synkes – risiko for at rigtige serveradresser
    #     deles utilsigtet eller overskrives uden historik.
    #
    # Invoke-AppDeployToolkit.ps1 læser CustomerSettings.psd1 og falder
    # tilbage til denne Example-fil, hvis den lokale fil ikke findes.
    #
    # SSL-VPN-tunnellen oprettes i FortiClient i Post-Install-fasen.
    # ============================================================

    # Navn på VPN-forbindelsen som vises i FortiClient-appen.
    VpnName        = 'Kunde VPN'

    # Beskrivelse som vises når forbindelsen redigeres i appen.
    VpnDescription = 'Kunde SSLVPN'

    # Adresse til SSL-VPN-gateway (host:port).
    VpnServer      = 'vpn.kunde.example:443'
}

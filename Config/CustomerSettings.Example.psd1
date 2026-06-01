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
    # SSL-VPN-tunnellen oprettes i FortiClient i Post-Install-fasen.
    # ============================================================

    # Navn på VPN-forbindelsen som vises i FortiClient-appen.
    VpnName        = 'Kunde VPN'

    # Beskrivelse som vises når forbindelsen redigeres i appen.
    VpnDescription = 'Kunde SSLVPN'

    # Adresse til SSL-VPN-gateway (host:port).
    VpnServer      = 'vpn.kunde.example:443'
}

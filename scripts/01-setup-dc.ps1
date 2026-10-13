<#
    01-setup-dc.ps1
    Zweck:  Richtet einen Windows Server 2025 als Domaincontroller
            fuer die Domaene test.local ein.
    Umgebung: Hyper-V-VM "Test-DC01" im internen Netz LAB-Intern
    Autor:  Simeon Bilbija
    Stand:  Oktober 2026

    Hinweis: Dieses Skript dokumentiert den Aufbau Schritt fuer Schritt.
             Der Hochstuf-Vorgang startet den Server am Ende automatisch neu.
#>

# --- 1. Feste IP-Adresse vergeben ---
# Ein Domaincontroller braucht eine feste IP, da er zugleich DNS-Server ist.
New-NetIPAddress -InterfaceAlias "Ethernet" `
    -IPAddress 192.168.10.10 `
    -PrefixLength 24 `
    -DefaultGateway 192.168.10.1

# --- 2. DNS-Server auf sich selbst zeigen lassen ---
# Der DC wird sein eigener DNS-Server, daher 127.0.0.1 (localhost).
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" `
    -ServerAddresses 127.0.0.1

# --- 3. Active-Directory-Rolle installieren ---
# Installiert AD DS samt der grafischen Verwaltungswerkzeuge.
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# --- 4. DSRM-Passwort sicher abfragen ---
# Wiederherstellungs-Passwort fuer den Notfall. Wird beim Lauf abgefragt,
# niemals im Klartext im Skript speichern.
$DSRM = Read-Host -Prompt "DSRM-Passwort eingeben" -AsSecureString

# --- 5. Neue Gesamtstruktur (Forest) mit Domaene test.local erstellen ---
# Macht aus dem Server den ersten Domaincontroller der neuen Domaene.
# -InstallDns richtet den DNS-Dienst gleich mit ein.
# Der Server startet nach Abschluss automatisch neu.
Install-ADDSForest -DomainName "test.local" `
    -DomainNetbiosName "TEST" `
    -InstallDns `
    -SafeModeAdministratorPassword $DSRM

# Windows Lab – Infrastructure as Code

Automatisierter Aufbau einer kompletten Windows-Domäne per Code.
Ziel: Eine ganze Firmen-IT (Domaincontroller, Benutzer, Gruppen,
Dateifreigaben und Gruppenrichtlinien) entsteht reproduzierbar aus
Skripten statt per Hand – löschbar und in Minuten neu aufbaubar.

## Hintergrund

Dieses Projekt entsteht im Rahmen meiner Ausbildung zum
Fachinformatiker für Systemintegration. Ich nutze es, um
Automatisierung, Active Directory und Infrastructure as Code in einer
eigenen Laborumgebung praktisch zu lernen.

## Eingesetzte Technik

- Windows Server 2025 (Hyper-V als Host)
- Active Directory Domain Services
- PowerShell / PowerShell DSC
- Git & GitHub

## Umgebung

- Hyper-V-Host mit mehreren virtuellen Maschinen
- Eine Domäne (DC, Fileserver, Clients)
- Internes Testnetz, getrennt vom Produktivnetz

## Projektstand

- [x] Projekt aufgesetzt, Repository angelegt
- [x] Domaincontroller automatisiert aufsetzen
- [ ] Benutzer & Gruppen aus Datei erzeugen
- [ ] Dateiserver mit Freigaben und Berechtigungen
- [ ] Gruppenrichtlinien per Code
- [ ] Monitoring

## Aufbau des Repos

- `scripts/` – PowerShell-Skripte zum Aufbau der Umgebung
  - `01-setup-dc.ps1` – Richtet den Domaincontroller der Domäne test.local ein

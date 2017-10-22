Installation der Testumgebung
-----------------------------

  * Installatio RVM
     * Das aktuelle Vorgehen für die Installation findet man in aktueller Version immer auf der offiziellen Homepage: https://rvm.io/ 
       ```
       gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
       \curl -sSL https://get.rvm.io | bash -s stable
       source /home/marc/.rvm/scripts/rvm
       rvm install "ruby-2.4.1"
       ```
     * Ruby installieren mit / Arbeiten mit den Control Repos
       Es gibt mehrere Möglichkeiten mit RVM zu interagieren. Die Informationen findet man unter Typical RVM Project Workflow. Die aktuell genutzte Variante ist über das Gemfile. Hier am Beispiel.
       Gemfile
       ```
       source 'https://rubygems.org'

       #ruby=2.0.0-p645
       #ruby-gemset=puppet-testing

       (...)
       ```
       Die auskommentierten ruby Variablen werden von RVM interpretiert. Die Ruby Version muss manuell installiert werden. 
       Es gibt eine entsprechende Fehlermeldung wenn dies nicht refolgt ist. Nachdem dies geschehen ist, sollte beim Wechsel in
       das geklonte Repository automatisch Bundler - das durch die Konfigurationvariable automatisch installiert wurde - die Ruby Gems unter dem angegebenen Gemset installieren.

       "test-kitchen": Serverspec Test mit Vagrant/Virtualbox/Docker
       ```
       # Frägt nach Sudo Passwort: Installiert libyaml-dev, libsqlite3-dev, libgdbm-dev, libncurses5-dev, bison, libreadline6-dev
       rvm install ruby-2.4
       ```
     * Konfiguration RVM<br>
       Nach der Installation von RVM, sollte man die Datei ~/.rvmrc mit folgendem Inhalt noch erstellen.
       Damit wird bei der Installation einer Ruby Version automatisch auch Bundler installiert, was mehr Komfort bringt.
       ```
       echo "rvm_autoinstall_bundler_flag=1" >> ~/.rvmrc
       ```
  * Installtion Kitchen
   * Siehe https://www.vagrantup.com/downloads.html
   * Download und Installation
     ```
     cd /tmp
     wget https://releases.hashicorp.com/vagrant/2.0.0/vagrant_2.0.0_x86_64.deb
     sudo dpkg -i vagrant_2.0.0_x86_64.deb
     ```
  * Modul und Dependencies
    ```
    git clone https://github.com/scoopex/puppet-kitchen_template.git
    # Dependencies werden automatisch installiert
    cd puppet-kitchen_template
    ```

Entwickeln und Testen
---------------------

 * In das Verzeichnis wechseln
   ```
   cd puppet-kitchen_template
   ```
 * Linux System Umgebung anlegen und einloggen
   ```
   kitchen create
   kitchen login
   sudo bash
   ```
 * Puppet ausführen<br>
   (Mit jeder Ausführung werden eben geänderte Dateien neu in die VM repliziert)
   ```
   kitchen converge
   ```
  * Serverspec Tests ausführen
   ```
   kitchen verify
   ```


Cheat Sheet
-----------

```
  Command                                             Beschreibung
  kitchen list             Zeigt alle Suiten an
  kitchen create           Erstellt das Zielsystem (Vagrant)
  kitchen create <suite>
  kitchen converge <suite> Führt den Provisioner aus (Puppet)
  kitchen login <suite>    SSH Login
  kitchen verify <suite>   Führt die Tests aus (servespec)
  kitchen test <suite>     Führt alle 3 Schritte nacheinander durch und zerstört das Zielsystem danach wieder
  kitchen destroy          Löscht alle Zielsysteme
  kitchen destroy <suite>  Löscht das Zielsystem einer Suite
```

Troubleshooting
---------------

 * Falls die Ruby Version z.B. nach einen Systemupdate nicht mehr stimmt
   ```
   rm -rf $HOME/.gem/
   bundle install
   gem install kitchen
   ```


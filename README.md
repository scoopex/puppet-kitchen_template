Overview
--------

This puppet project template provides the following aspects:

  * puppet template with demo code which installs a lighthttpd
  * convenient development environment 
    * which downloads and creates a ubuntu xenial image in a virtualbox environment
    * basic installation of puppet 4 client
    * automatic installation of puppet modules specified in the "Puppetfile"
  * serverspec tests are executed in the environment

Resources
---------

 * this project is based/located on https://github.com/scoopex/puppet-kitchen_template
 * test kitchen: https://github.com/test-kitchen/test-kitchen
 * serverspec tests
  * ressources : http://serverspec.org/resource_types.html

Installation of the test environment
------------------------------------

  * Install virtualbox: https://www.virtualbox.org/wiki/Linux_Downloads
  * Installation of vagrant
   * see: https://www.vagrantup.com/downloads.html
   * Download und Installation
     ```
     cd /tmp
     wget https://releases.hashicorp.com/vagrant/2.0.0/vagrant_2.0.0_x86_64.deb
     sudo dpkg -i vagrant_2.0.0_x86_64.deb
     ```
  * Clone the repo
    ```
    git clone https://github.com/scoopex/puppet-kitchen_template.git
    cd puppet-kitchen_template
    ```
  * Installation of RVM
     * Follow the offical installation procedure at https://rvm.io/, i.e.:
       ```
       gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
       \curl -sSL https://get.rvm.io | bash -s stable
       source /home/marc/.rvm/scripts/rvm
       rvm install "ruby-2.4.1"
       ```
     * Configuration of RVM<br>
       After the rvm installtion a configuration file (~/.rvmrc) should be created with the following content:
       ```
       echo "rvm_autoinstall_bundler_flag=1" >> ~/.rvmrc
       ```
       This allows the convinient automatic installation of bundler.

     * Install Ruby, work with control repositories
       There are numerous possibilities to work with RVM - we are unsing the Gemfile procedure.
       see: Gemfile
       ```
       source 'https://rubygems.org'

       #ruby=2.0.0-p645
       #ruby-gemset=puppet-testing

       (...)
       ```
       The entries with the leading hashes (#) are not disabled entries. You have to install the configured ruby release in a manual procedure.
       You will get a notification "Required ruby-2.4.1 is not installed." if this step is missing.

       "test-kitchen": Serverspec Test mit Vagrant/Virtualbox/Docker
       ```
       exec bash
       cd ..; cd puppet-kitchen_template
       # Frägt nach Sudo Passwort: Installiert libyaml-dev, libsqlite3-dev, libgdbm-dev, libncurses5-dev, bison, libreadline6-dev
       rvm install ruby-2.4
       # Now the automatic invocation of bundler should install all the missing gems
       cd ..; cd puppet-kitchen_template
       ```

Develop and test puppet code
-------------------------------

 * Change to the directory
   ```
   cd puppet-kitchen_template
   ```
 * Add Puppet modules and edit sourcecode
   ```
   vim Puppetfile manifests/* test/integration/default/serverspec/*
   ```
 * Deploy a test system and login to the system for debugging purposes
   ```
   kitchen list
   kitchen create <instance>
   kitchen login <instance>
   sudo bash
   ```
 * Execute puppet withe the current code
   ```
   kitchen converge <instance>
   ```
 * Execute serverspec tests
   ```
   kitchen verify <instance>
   ```

Cheat Sheet
-----------

  ```
  Command                  Description
  kitchen list             View all test suites
  kitchen create           Create the target system (Vagrant)
  kitchen create <suite>
  kitchen converge <suite> Execute puppet (Puppet)
  kitchen login <suite>    SSH Login
  kitchen verify <suite>   Execute test suites (servespec)
  kitchen test <suite>     Create, test and destroy system
  kitchen destroy          Destroy all test systems
  kitchen destroy <suite>  Destroy a certain test system
  ```

Use it in your own project
------------------------------------

 * Fork in on github, name it puppet-<projectname>
 * Clone the repo
 * Rename the folder to the name of your project, "puppet-<your-project-name>
 * Replace all occurrences of the template name
   ```
   cd <project>
   PROJECT_NAME="$(basename $PWD|sed '~s,puppet-,,')"
   grep -n -r "kitchen_template" .|cut -d ':' -f1|sort -u|xargs sed -i "~s,kitchen_template,${PROJECT_NAME},g"
   ```
 * Execute the steps in section "Develop and test puppet code"
 * Commit && Push

Merge changes of the template to your project
---------------------------------------------

 * Using GIT
   ```
   git remote add upstream https://github.com/scoopex/puppet-kitchen_template.git
   git fetch upstream
   git checkout master
   git merge upstream/master
   ```
 * Manual (timeconsuming way) way
   ```
   cd /tmp
   git clone https://github.com/scoopex/puppet-kitchen_template.git
   cd /your-project
   diff -r --brief -x .librarian -x .git -x Gemfile.lock -x .kitchen -x .tmp /tmp/puppet-kitchen_template
   vim -d /tmp/puppet-kitchen_template/<file> <file>
   ```

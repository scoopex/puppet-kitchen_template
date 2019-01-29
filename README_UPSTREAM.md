Use it in your own project
------------------------------------

HINT: Use the original project template from https://github.com/scoopex/puppet-kitchen_template

 * Find a new name (name should not contain dashes)
   ```
   PROJECT_NAME="<name>"
   REPONAME="puppet-${PROJECT_NAME}"
   ```
 * Fork in on github, name it puppet-<projectname> or clone directory
   ```
   git clone https://github.com/scoopex/puppet-kitchen_template $REPONAME
   cd $REPONAME
   rm -rf .git
   ```
 * Replace all occurrences of the template name
   ```
   grep -n --exclude=README_UPSTREAM.md -r "kitchen_template" .|cut -d ':' -f1|sort -u|while read A; do sed -i "~s,kitchen_template,${PROJECT_NAME},g" $A; done
   git init
   git add -A .
   ```
 * Execute the steps in section "Develop and test puppet code" in [README.md](README.md)
 * Create a git project in your git server
 * Commit && Push
   ```
   git commit -m "Initial checkin" -a
   git remote add origin <repo url>
   git push -u origin --all
   git push -u origin --tags
   ```

Merge changes of the template to your project
---------------------------------------------

 * Using GIT
   ```
   git remote add upstream https://github.com/scoopex/puppet-kitchen_template.git
   git fetch upstream
   git checkout master
   git merge upstream/master
   ```
 * Manual (time consuming way) way
   ```
   cd /tmp
   git clone https://github.com/scoopex/puppet-kitchen_template.git
   cd /your-project
   diff -r --brief -x .librarian -x .git -x Gemfile.lock -x .kitchen -x .tmp /tmp/puppet-kitchen_template
   vim -d /tmp/puppet-kitchen_template/<file> <file>
   ```

Contribution
------------

 * file a bug on the github project: https://github.com/scoopex/puppet-kitchen_template/issues
 * fork the project and improve the template
 * create a pull/merge request


#!/bin/bash

#
mkdir -p "./build"

#
pkgbuild --analyze --root "./Applications"  "build/App.plist"
#
plutil -replace 'BundleIsRelocatable' -bool NO "build/App.plist"
plutil -insert 'BundlePreInstallScriptPath' -string 'preinstall' "build/App.plist"
plutil -insert 'BundlePostInstallScriptPath' -string 'postinstall' "build/App.plist"
#
pkgbuild --root "./Applications" --component-plist "build/App.plist" --identifier "App.ShellCommand_MacApp" --version "0.1.0" --install-location "/Applications" --scripts "resource" "build/App.pkg"


#
productbuild --synthesize --package "build/App.pkg" "build/Distribution.xml"

#
awk 'NR==14{print "\t<title>App</title>\n\t<background file=\"background.png\" scaling=\"none\"/>\n\t<readme file=\"ReadMe.txt\" mime-type=\"text/plain\"/>\n\t<license file=\"Licence.txt\" mime-type=\"text/plain\"/>\n\t<welcome file=\"Welcome.txt\" mime-type=\"text/plain\"/>";}{print}' "build/Distribution.xml" > "build/Distribution2.xml"

#
productbuild  --distribution "build/Distribution2.xml" --resources "resource" --package-path "." "build/App_Installer.pkg"
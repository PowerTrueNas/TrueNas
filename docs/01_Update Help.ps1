#
# Copyright 2019, Jérôme Bezet-Torres <bezettorres dot jerome at gmail dot com>
#
# SPDX-License-Identifier: Apache-2.0
#
#Requires -Modules @{ ModuleName="PlatyPS"; RequiredVersion="0.9.0"}
#Requires -Modules FreeNas

$TestsPath = Split-Path $MyInvocation.MyCommand.Path
$RootFolder = (get-item $TestsPath).Parent
Push-Location -Path $RootFolder.FullName
set-location -Path $RootFolder.FullName
Write-Verbose -Message "Importing modules"
import-module .\Freenas -Force
import-module platyPS

Update-MarkdownHelp -Path $TestsPath\Functions -LogAppend

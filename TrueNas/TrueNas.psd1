#
# Manifeste de module pour le module « TrueNas »
#
# Généré par : Jérôme Bezet-Torres
#
# Généré le : 19/02/2019
#

@{

    # Module de script ou fichier de module binaire associé à ce manifeste
    RootModule        = './TrueNas.psm1'

    # Numéro de version de ce module.
    ModuleVersion     = '21.03.12'

    # Éditions PS prises en charge
    # CompatiblePSEditions = @()

    # ID utilisé pour identifier de manière unique ce module
    GUID              = 'd7587fec-cddd-43bd-857f-a043f76d3df9'

    # Auteur de ce module
    Author            = 'Jérôme Bezet-Torres'

    # Société ou fournisseur de ce module
    CompanyName       = 'JM2K69.github.io'

    # Déclaration de copyright pour ce module
    Copyright         = '(c) 2019 Jérôme Bezet-Torres. Tous droits réservés.'

    # Description de la fonctionnalité fournie par ce module
    Description       = 'This module interact with TrueNas Core and Enterprise with the API REST 2.0'

    # Version minimale du moteur Windows PowerShell requise par ce module
    # PowerShellVersion = ''

    # Nom de l'hôte Windows PowerShell requis par ce module
    # PowerShellHostName = ''

    # Version minimale de l'hôte Windows PowerShell requise par ce module
    # PowerShellHostVersion = ''

    # Version minimale du Microsoft .NET Framework requise par ce module. Cette configuration requise est valide uniquement pour PowerShell Desktop Edition.
    # DotNetFrameworkVersion = ''

    # Version minimale de l’environnement CLR (Common Language Runtime) requise par ce module. Cette configuration requise est valide uniquement pour PowerShell Desktop Edition.
    # CLRVersion = ''

    # Architecture de processeur (None, X86, Amd64) requise par ce module
    # ProcessorArchitecture = ''

    # Modules qui doivent être importés dans l'environnement global préalablement à l'importation de ce module
    # RequiredModules = @()

    # Assemblys qui doivent être chargés préalablement à l'importation de ce module
    # RequiredAssemblies = @()

    # Fichiers de script (.ps1) exécutés dans l’environnement de l’appelant préalablement à l’importation de ce module
    # ScriptsToProcess = @()

    # Fichiers de types (.ps1xml) à charger lors de l'importation de ce module
    # TypesToProcess = @()

    # Fichiers de format (.ps1xml) à charger lors de l'importation de ce module
    # FormatsToProcess = @()

    # Modules à importer en tant que modules imbriqués du module spécifié dans RootModule/ModuleToProcess
    # NestedModules = @()

    # Fonctions à exporter à partir de ce module. Pour de meilleures performances, n’utilisez pas de caractères génériques et ne supprimez pas l’entrée. Utilisez un tableau vide si vous n’avez aucune fonction à exporter.
    # FunctionsToExport = @()

    # Applets de commande à exporter à partir de ce module. Pour de meilleures performances, n’utilisez pas de caractères génériques et ne supprimez pas l’entrée. Utilisez un tableau vide si vous n’avez aucune applet de commande à exporter.
    # CmdletsToExport   = @()

    # Variables à exporter à partir de ce module
    VariablesToExport = '*'

    # Alias à exporter à partir de ce module. Pour de meilleures performances, n’utilisez pas de caractères génériques et ne supprimez pas l’entrée. Utilisez un tableau vide si vous n’avez aucun alias à exporter.
    # AliasesToExport   = @()

    # Ressources DSC à exporter depuis ce module
    # DscResourcesToExport = @()

    # Liste de tous les modules empaquetés avec ce module
    # ModuleList = @()

    # Liste de tous les fichiers empaquetés avec ce module
    # FileList = @()

    # Données privées à transmettre au module spécifié dans RootModule/ModuleToProcess. Cela peut également inclure une table de hachage PSData avec des métadonnées de modules supplémentaires utilisées par PowerShell.
    PrivateData       = @{

        PSData = @{

            # Des balises ont été appliquées à ce module. Elles facilitent la découverte des modules dans les galeries en ligne.
            Tags       = 'API', 'TrueNas', 'FreeNas', 'REST', 'iSCSI', 'PSEdition_Desktop', 'PSEdition_Core'

            # URL vers la licence de ce module.
            # LicenseUri = ''

            # URL vers le site web principal de ce projet.
            ProjectUri = 'https://github.com/JM2K69/TrueNas'

            # URL vers une icône représentant ce module.
            IconUri    = 'https://raw.githubusercontent.com/JM2K69/TrueNas/master/img/TrueNas.png'

            # Prerelease string of this module
            Prerelease = 'alpha'

            # Propriété ReleaseNotes de ce module

        } # Fin de la table de hachage PSData

    } # Fin de la table de hachage PrivateData

    # URI HelpInfo de ce module
    # HelpInfoURI = ''

    # Le préfixe par défaut des commandes a été exporté à partir de ce module. Remplacez le préfixe par défaut à l’aide d’Import-Module -Prefix.
    # DefaultCommandPrefix = ''

}

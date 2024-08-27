param (
    [string]$mod_version,
    [string]$spt_version
)

# Define the release directory
$releaseDir = ".\release"

# Create release directory if it doesn't exist
if (-Not (Test-Path -Path $releaseDir)) {
    New-Item -ItemType Directory -Path $releaseDir -Force
}

# Create directory names within the release directory
$baseDir = "$releaseDir\msg-realism-compatibility_v${mod_version}_SPT-v${spt_version}"

# Define the inner directory structure
$innerDir = "user\mods\SPT-Realism\db\put_new_stuff_here\Massivesofts Guns"

# Create the directories
New-Item -ItemType Directory -Path "$baseDir\$innerDir" -Force

# Define the list of files to move
$filesToMove = @(
    'Massivesofts Guns\ISO.json'
    'Massivesofts Guns\JAK_12.json',
    'Massivesofts Guns\M14.json',
    'Massivesofts Guns\M1911CE.json',
    'Massivesofts Guns\QBZ-03.json',
    'Massivesofts Guns\QBZ-97.json',
    'Massivesofts Guns\Tavor_X95.json',
    'Massivesofts Guns\Type_64.json',
    'Massivesofts Guns\V308.json'
)

# Move files to both directories
foreach ($file in $filesToMove) {
    Copy-Item -Path $file -Destination "$baseDir\$innerDir"
}

# Create zip files
Compress-Archive -Path "$baseDir\*" -DestinationPath "$releaseDir\msg-realism-compatibility_v${mod_version}_SPT-v${spt_version}.zip" -Force

# Clean up the created directories
Remove-Item -Recurse -Force "$baseDir"

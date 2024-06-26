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
$baseDir1 = "$releaseDir\msg-realism-compatibility_v${mod_version}_SPT-v${spt_version}"
$baseDir2 = "$releaseDir\msg-realism-compatibility_v${mod_version}_SPT-v${spt_version}-alternate"

# Define the inner directory structure
$innerDir = "user\mods\SPT-Realism\db\put_new_stuff_here\Massivesofts Guns"

# Create the directories
New-Item -ItemType Directory -Path "$baseDir1\$innerDir" -Force
New-Item -ItemType Directory -Path "$baseDir2\$innerDir" -Force

# Define the list of files to move
$filesToMove = @(
    'Massivesofts Guns\M14.json',
    'Massivesofts Guns\M1911CE.json',
    'Massivesofts Guns\QBZ-03.json',
    'Massivesofts Guns\Type_64.json',
    'Massivesofts Guns\V308.json'
)

# Move files to both directories
foreach ($file in $filesToMove) {
    Copy-Item -Path $file -Destination "$baseDir1\$innerDir"
    Copy-Item -Path $file -Destination "$baseDir2\$innerDir"
}

# Move specific files to respective directories
Copy-Item -Path 'Massivesofts Guns\JAK_12.json' -Destination "$baseDir1\$innerDir"
Copy-Item -Path 'Massivesofts Guns\AA_12.json' -Destination "$baseDir2\$innerDir"

# Create zip files
Compress-Archive -Path "$baseDir1\*" -DestinationPath "$releaseDir\msg-realism-compatibility_v${mod_version}_SPT-v${spt_version}.zip" -Force
Compress-Archive -Path "$baseDir2\*" -DestinationPath "$releaseDir\msg-realism-compatibility_v${mod_version}_SPT-v${spt_version}-alternate.zip" -Force

# Clean up the created directories
Remove-Item -Recurse -Force "$baseDir1"
Remove-Item -Recurse -Force "$baseDir2"

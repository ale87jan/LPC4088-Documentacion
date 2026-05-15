# clean_keil.ps1 — Elimina artefactos de compilación de Keil µVision
# Uso: .\clean_keil.ps1 [-WhatIf]
# Ejemplo: .\clean_keil.ps1 -WhatIf   # previsualizar sin borrar
#          .\clean_keil.ps1           # borrar realmente

param([switch]$WhatIf)

$root = $PSScriptRoot ? $PSScriptRoot : $PWD.Path

$foldersToRemove = @("Listings", "Objects", "RTE")
$filePatterns    = @("*.uvguix.ale87", "JLinkLog.txt", "JLinkSettings.ini")

# Verifica si una ruta contiene un segmento que empiece con "."
function Has-DotSegment([string]$fullPath) {
    $relative = $fullPath.Substring($root.Length).TrimStart('\', '/')
    ($relative -split '[\\\/]') | Where-Object { $_ -like '.*' } | Select-Object -First 1
}

$removed = 0

Write-Host "Buscando artefactos de Keil µVision en: $root`n"

# Carpetas: ordenar de más profunda a raíz para evitar errores al borrar padres primero
Get-ChildItem -Path $root -Recurse -Directory -Force |
    Where-Object { $_.Name -in $foldersToRemove -and -not (Has-DotSegment $_.FullName) } |
    Sort-Object { $_.FullName.Length } -Descending |
    ForEach-Object {
        if (-not (Test-Path $_.FullName)) { return }   # ya fue borrado como hijo
        if ($WhatIf) { Write-Host "[WhatIf] Carpeta: $($_.FullName)" }
        else {
            Write-Host "Borrando carpeta: $($_.FullName)"
            Remove-Item $_.FullName -Recurse -Force
            $removed++
        }
    }

# Archivos individuales
foreach ($pattern in $filePatterns) {
    Get-ChildItem -Path $root -Recurse -Filter $pattern -Force |
        Where-Object { -not (Has-DotSegment $_.FullName) } |
        ForEach-Object {
            if ($WhatIf) { Write-Host "[WhatIf] Archivo: $($_.FullName)" }
            else {
                Write-Host "Borrando archivo: $($_.FullName)"
                Remove-Item $_.FullName -Force
                $removed++
            }
        }
}

Write-Host ""
if ($WhatIf) { Write-Host "Modo WhatIf: nada fue borrado." }
else         { Write-Host "Limpieza completa. Elementos eliminados: $removed" }

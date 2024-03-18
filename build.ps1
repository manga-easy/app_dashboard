

# Execute o comando 'flutter build apk' para construir o APK
flutter build apk --release --no-tree-shake-icons
flutter build windows --release --no-tree-shake-icons
# Defina o caminho para o APK construído
$apkPath = Get-ChildItem -Path ".\build\app\outputs\flutter-apk\" -Filter "app-release.apk" -Recurse

# Verifique se o arquivo APK foi construído com sucesso
if ($apkPath) {
    # Obtenha a versão do projeto Flutter (pode ser obtida de pubspec.yaml)
   # Obter a linha que contém a versão do arquivo pubspec.yaml
    $version = (Get-Content "pubspec.yaml" | Select-String "version:")

    # Extrair a parte relevante da linha
    $version = $version -replace 'version:', ''

    # Remover espaços em branco em excesso
    $version = $version.Trim()

    Write-Host $version
    if ($version) {
        # Defina o novo nome do arquivo APK com base na versão do projeto Flutter
        $newApkName = "dash-$version.apk"
        # Renomeie o arquivo APK para o novo nome
        Rename-Item -Path $apkPath.FullName -NewName $newApkName

        Write-Host "APK construído e renomeado com sucesso para $newApkName"
    }
    else {
        Write-Host "Erro: não foi possivel buscar a versão"
    }   
}
else {
    Write-Host "Erro: O APK não foi construído corretamente."
}

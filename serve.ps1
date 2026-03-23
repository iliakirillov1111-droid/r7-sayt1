$port = 8000
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
try {
    $listener.Start()
    Write-Host "Server started at http://localhost:$port/"
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response
        
        $url = $request.Url.LocalPath
        if ($url -eq "/") { $url = "/index.html" }
        
        $path = Join-Path $pwd $url.TrimStart('/')
        
        if (Test-Path $path -PathType Leaf) {
            $content = [System.IO.File]::ReadAllBytes($path)
            $response.ContentType = "text/html"
            if ($path.EndsWith(".css")) { $response.ContentType = "text/css" }
            if ($path.EndsWith(".js")) { $response.ContentType = "application/javascript" }
            
            $response.ContentLength64 = $content.Length
            $response.OutputStream.Write($content, 0, $content.Length)
        } else {
            $response.StatusCode = 404
        }
        $response.Close()
    }
} finally {
    $listener.Stop()
}

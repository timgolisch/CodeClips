Public Class ZipFile
    Private FileBytes() As Byte

    Public Sub AddFile(fileContent As String, path As String, fileName As String)

    End Sub

    Public Function GetZipFile() As Byte()



    End Function

    ' Method to compress.
    Private Sub Compress(file As String)
        Dim fileBytes() As Byte

        fileBytes = System.Text.Encoding.UTF8.GetBytes(file)

        ' Create the compressed file.
        Using outFile As IO.MemoryStream = New IO.MemoryStream(FileBytes)
            Using Compress As IO.Compression.GZipStream = _
             New IO.Compression.GZipStream(outFile, IO.Compression.CompressionMode.Compress, True)

                ' Copy the source file into the compression stream.
                Compress.Read(fileBytes, 0, fileBytes.Length)


            End Using
        End Using

    End Sub


End Class

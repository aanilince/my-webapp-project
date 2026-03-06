<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Note Application</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <div class="container">
        <h1>Note Application</h1>

        <!-- Form Section -->
        <div class="form-section">
            <h2>Add a New Note</h2>
            <form id="noteForm">
                <div class="form-group">
                    <label for="authorInput">Author Name</label>
                    <input type="text" id="authorInput" placeholder="Enter your name" required>
                </div>
                <div class="form-group">
                    <label for="noteInput">Note Content</label>
                    <textarea id="noteInput" placeholder="Write your note here..." required></textarea>
                </div>
                <button type="submit">Add Note</button>
            </form>
        </div>

        <!-- Notes Display Section -->
        <div class="notes-section">
            <h2>Notes</h2>
            <div id="notesList"></div>
        </div>
    </div>

    <script src="js/app.js"></script>

</body>
</html>
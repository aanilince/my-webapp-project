<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Note Application</title>
    <style>
        /* This targets the main container of the page */
        body {
            /* 1. Reset default browser margins */
            margin: 0;
            padding: 20px;

            /* 2. Use Flexbox for layout */
            display: flex;
            justify-content: center;   /* Centers horizontally */
            align-items: flex-start;   /* Aligns to top */
            min-height: 100vh;

            /* 3. Visual Styles */
            background-color: #282c34; /* Dark blue-grey background */
            font-family: sans-serif;   /* Clean, modern font */
        }

        /* Main container */
        .container {
            width: 100%;
            max-width: 800px;
        }

        /* This targets the text specifically */
        h1 {
            color: #61dafb;      /* Bright cyan for contrast */
            font-size: 3rem;     /* Large text */
            font-weight: 700;    /* Bold thickness */
            text-align: center;  /* Centered */
            margin: 0 0 40px 0;
        }

        h2 {
            color: #61dafb;
            font-size: 1.5rem;
            margin-top: 30px;
            margin-bottom: 15px;
        }

        /* Form styling */
        .form-section {
            background-color: #3d4247;
            border: 2px solid #61dafb;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            color: #61dafb;
            font-weight: 600;
            margin-bottom: 8px;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            background-color: #282c34;
            color: #61dafb;
            border: 1px solid #61dafb;
            border-radius: 4px;
            font-family: sans-serif;
            font-size: 1rem;
            box-sizing: border-box;
        }

        input[type="text"]:focus,
        textarea:focus {
            outline: none;
            box-shadow: 0 0 8px #61dafb;
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        button {
            background-color: #61dafb;
            color: #282c34;
            border: none;
            padding: 12px 30px;
            border-radius: 4px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        button:hover {
            background-color: #4fa8c5;
            transform: translateY(-2px);
        }

        button:active {
            transform: translateY(0);
        }

        /* Notes container */
        .notes-section {
            margin-top: 30px;
        }

        .note {
            background-color: #3d4247;
            border-left: 4px solid #61dafb;
            border-radius: 4px;
            padding: 15px;
            margin-bottom: 15px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
        }

        .note-content {
            color: #ffffff;
            margin-bottom: 10px;
            word-wrap: break-word;
        }

        .note-author {
            color: #61dafb;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .note-timestamp {
            color: #999999;
            font-size: 0.8rem;
            margin-top: 8px;
        }

        .delete-btn {
            background-color: #ff6b6b;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 0.85rem;
            cursor: pointer;
            margin-top: 10px;
            transition: all 0.3s ease;
        }

        .delete-btn:hover {
            background-color: #ff5252;
        }

        .empty-message {
            color: #999999;
            text-align: center;
            padding: 20px;
            font-style: italic;
        }
    </style>
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

    <script>
        // Note Management Functions
        const noteForm = document.getElementById('noteForm');
        const authorInput = document.getElementById('authorInput');
        const noteInput = document.getElementById('noteInput');
        const notesList = document.getElementById('notesList');

        // Load notes from localStorage
        function loadNotes() {
            const notes = JSON.parse(localStorage.getItem('notes')) || [];
            return notes;
        }

        // Save notes to localStorage
        function saveNotes(notes) {
            localStorage.setItem('notes', JSON.stringify(notes));
        }

        // Display all notes
        function displayNotes() {
            const notes = loadNotes();
            notesList.innerHTML = '';

            if (notes.length === 0) {
                notesList.innerHTML = '<div class="empty-message">No notes yet. Add your first note above!</div>';
                return;
            }

            notes.forEach((note, index) => {
                const noteElement = document.createElement('div');
                noteElement.className = 'note';
                noteElement.innerHTML = `
                    <div class="note-content">${escapeHtml(note.content)}</div>
                    <div class="note-author">By: ${escapeHtml(note.author)}</div>
                    <div class="note-timestamp">${new Date(note.timestamp).toLocaleString()}</div>
                    <button class="delete-btn" onclick="deleteNote(${index})">Delete</button>
                `;
                notesList.appendChild(noteElement);
            });
        }

        // Add a new note
        function addNote(author, content) {
            const notes = loadNotes();
            notes.unshift({
                author: author,
                content: content,
                timestamp: new Date().toISOString()
            });
            saveNotes(notes);
            displayNotes();
        }

        // Delete a note
        function deleteNote(index) {
            const notes = loadNotes();
            notes.splice(index, 1);
            saveNotes(notes);
            displayNotes();
        }

        // Escape HTML to prevent XSS
        function escapeHtml(text) {
            const div = document.createElement('div');
            div.textContent = text;
            return div.innerHTML;
        }

        // Form submission handler
        noteForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const author = authorInput.value.trim();
            const content = noteInput.value.trim();

            if (author && content) {
                addNote(author, content);
                authorInput.value = '';
                noteInput.value = '';
                authorInput.focus();
            }
        });

        // Initialize on page load
        displayNotes();
    </script>

</body>
</html>
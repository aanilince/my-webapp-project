// Note Management Functions
const noteForm = document.getElementById('noteForm');
const authorInput = document.getElementById('authorInput');
const noteInput = document.getElementById('noteInput');
const notesList = document.getElementById('notesList');

// API Base URL
const API_URL = '/api/notes';

// Load notes from server
async function loadNotes() {
    try {
        const response = await fetch(API_URL);
        if (response.ok) {
            return await response.json();
        } else {
            console.error('Failed to load notes');
            return [];
        }
    } catch (error) {
        console.error('Error loading notes:', error);
        return [];
    }
}

// Display all notes
async function displayNotes() {
    const notes = await loadNotes();
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
            <button class="delete-btn" onclick="deleteNote(${note.id})">Delete</button>
        `;
        notesList.appendChild(noteElement);
    });
}

// Add a new note
async function addNote(author, content) {
    try {
        const response = await fetch(API_URL, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                author: author,
                content: content
            })
        });

        if (response.ok) {
            displayNotes();
        } else {
            alert('Failed to add note');
        }
    } catch (error) {
        console.error('Error adding note:', error);
        alert('Error adding note');
    }
}

// Delete a note
async function deleteNote(id) {
    try {
        const response = await fetch(`${API_URL}/${id}`, {
            method: 'DELETE'
        });

        if (response.ok) {
            displayNotes();
        } else {
            alert('Failed to delete note');
        }
    } catch (error) {
        console.error('Error deleting note:', error);
        alert('Error deleting note');
    }
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

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello World</title>
    <style>
        /* This targets the main container of the page */
        body {
            /* 1. Reset default browser margins */
            margin: 0;

            /* 2. Set the height to 100% of the viewport (screen) height */
            height: 100vh;

            /* 3. Use Flexbox to center the content */
            display: flex;
            justify-content: center; /* Centers horizontally */
            align-items: center;     /* Centers vertically */

            /* 4. Visual Styles */
            background-color: #282c34; /* Dark blue-grey background */
            font-family: sans-serif;   /* Clean, modern font */
        }

        /* This targets the text specifically */
        h1 {
            color: #61dafb;      /* Bright cyan for contrast */
            font-size: 5rem;     /* Very large text */
            font-weight: 700;    /* Bold thickness */
            text-align: center;  /* Ensures text stays centered if it wraps */
        }
    </style>
</head>
<body>

    <h1>Hello World</h1>

</body>
</html>
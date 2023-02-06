const port = process.env.PORT || 3000,
express = require('express' ),
app = express () ;

app.listen (port, () => {
    console.log('Servidor corriendo en puerto' + port);
});
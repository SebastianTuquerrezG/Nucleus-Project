const express = require('express');
const { SUBSCR_EVENT_TYPE_SHUTDOWN } = require('oracledb');
const app = express();
var bodyParser = require("body-parser");
var methodOverride = require("method-override")
var dao = require("./dao");
const cors = require('cors');
app.use (bodyParser.urlencoded ({ extended: false }));
app.use (bodyParser.json (0));
app.use (methodOverride());
app.use((req, res, next) => {

// Dominio que tengan acceso (ej. 'http://example.com')
    res.setHeader('Access-Control-Allow-Origin', '*');

// Metodos de solicitud que deseas permitir
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');

// Encabecedados que permites (ej. 'X-Requested-With,content-type')
    res.setHeader('Access-Control-Allow-Headers', '*');

next();
})

app.use(cors())
var router = express.Router ()
router.get('/usuario' , function(request, response){
    var opc = parseInt(request.query.opc);
    switch(opc){
        case 1:
            var sql = "SELECT * from usuario";
            dao.open(sql, [], false, response);
            break;
        case 2:
            var sql = "select vid_id,vid_nombre,emp_nombre from videojuego inner join empresaexterior on videojuego.emp_id = empresaexterior.emp_id";
            dao.open(sql, [], false, response);
            break;
        default:
            response.contentType('application/json').status(200);
    }
});

app.use(router);

app.listen(3000, function(){
    console.log('Servidor corriendo en http://localhost:3000');
})
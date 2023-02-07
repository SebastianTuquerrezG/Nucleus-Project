document.addEventListener("DOMContentLoaded", function(){
    document.getElementById("formulario").addEventListener("submit", function(event){
        event.preventDefault();
        var cns={
            user: "Nucleus_Project ",
            password: "2802",
            connectString: "localhost:1522/xe"
        };
        var mail_user = document.getElementById("mail_user").value;
        var pw_user = document.getElementById("pw_user").value;
        // Aquí debes agregar la lógica para conectarte al servidor de Oracle
        // y validar las credenciales de mail_user y pw_user.
        //
        // En este ejemplo se utiliza una conexión ODBC, pero esto puede variar
        // dependiendo de cómo hayas configurado tu servidor de Oracle.
        var oracle = require("oracledb");
        oracle.getConnection (cns, function(err, cn){
            if (error(err, rs, null)==-1) return;
            cn.execute (sql, binds, {autoCommit: dml}, function (err, result){
                                                            if (err) {
                                                                console.error(err);
                                                                return;
                                                            }
                                                            connection.query("SELECT COUNT(*) FROM usuarios WHERE mail_user = '" + mail_user + "' AND pw_user = '" + pw_user + "'", function(error, result) {
                                                                if (error) {
                                                                    console.error(error);
                                                                    return;
                                                                }
                                                                if (result[0]["COUNT(*)"] > 0) {
                                                                    
                                                                } else {
                                                                    alert("Usuario o contraseña incorrectos");
                                                                }
                                                                connection.close();
                                                            });
            });
        })
    });
});
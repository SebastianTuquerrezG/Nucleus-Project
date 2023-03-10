var objoracle = require('oracledb');
var cns={
        user: "Nucleus_Project ",
        password: "2802",
        connectString: "localhost:1522/xe"
    };

function error (err, rs, cn) {
    if (err){
        console.log(err.message);
        rs.contentType('application/json').status(500);
        if (cn!=null) close(cn) ;
        return-1
    }
    else
        return 0;
}

function open (sql, binds, dml, rs) {
    objoracle.getConnection (cns, function(err, cn){
        if (error (err, rs, null)==-1) return;
        cn.execute (sql, binds, {autoCommit: dml}, function (err, result){
                                                        if (error (err, rs, cn)==-1) return;
                                                        rs.contentType ('application/json').status(200);
                                                        if (dml)
                                                            rs.send (JSON.stringify (result.rowsAffected));
                                                        else{   
                                                            console.log (result.metaData);
                                                            rs.send(JSON.stringify(result.rows));
                                                        }
                                                        close (cn);
        });
    })
}

function close (cn){
    cn.release (
        function (err){
            if (err) console.error(err.message);
        });
}

exports.open = open;
exports.close=close;
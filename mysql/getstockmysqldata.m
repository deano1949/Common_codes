function dat=getstockmysqldata(conn,symbol)
% INPUT:    conn: established database connection
%           query: mysql commands in text
% OUTPUT:   dat: output data

query_template=['SELECT e.date,e.open_price,e.close_price,e.high_price,e.low_price FROM input.stock f '...
'join input.eod_data e on f.id=e.instrument_id '...
'where f.symbol="?"'];
query=strrep(query_template,'?',symbol);

curs=exec(conn,query,30);
curs=fetch(curs);
dat=curs.Data;

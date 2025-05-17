let result = [];

for (let i=0; i < size(); i++) {
    let obj = {};
    obj.row = i;
    obj.mimetypes = str(read("?", i)).trim().split("\n");
    // obj.data = read(obj.mimetypes[0], i);
    result.push(obj);
}
JSON.stringify(result);

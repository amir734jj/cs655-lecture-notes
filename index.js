const findFiles = require('file-regex')
const express = require('express')
const path = require('path')
const fs = require('fs')
const app = express()
const port = process.env.PORT || 3000

function flatten(arr) {
    return arr.reduce(function(flat, toFlatten) {
        return flat.concat(Array.isArray(toFlatten) ? flatten(toFlatten) : toFlatten);
    }, []);
}


let payload = {files:[], videos:[]};
findFiles(__dirname, /lab\d+\/\w+\.pdf/g, 1)
    .then(files => {
        payload.files = files.map(props => {
            const path = props.dir.substring(props.dir.lastIndexOf('/') + 1);
            return {
                name: props.file,
                path: path,
                url: path + '/' + props.file
            }
        }).sort((x, y) => x.path.localeCompare(y.path))
    })

findFiles(__dirname, /lab\d+\/video\.json/g, 1)
    .then(videos => {
        payload.videos = flatten(videos.map(props => {
            return JSON.parse(fs.readFileSync(path.join(props.dir, props.file), {
                encoding: 'utf8'
            }))
        })).reverse();
    })


app.use(express.static('.'))

app.set('view engine', 'pug')

app.get('/', (req, res) => {
    res.render('index', payload);
})

app.listen(port, () => console.log(`Example app listening on port ${port}!`))

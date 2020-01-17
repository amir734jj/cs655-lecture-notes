const findFiles = require('file-regex')
const express = require('express')
const app = express()
const port = process.env.PORT || 3000

let files = [];
findFiles(__dirname, /lab\d+\/\w+\.pdf/g, 1)
    .then(file => {
        files = file.map(props => {
            const path = props.dir.substring(props.dir.lastIndexOf('/') + 1);
            return {
                name: path,
                url: path + '/' + props.file
            }
        })

        files.sort((x, y) => x.name.localeCompare(y.name))
    })

app.use(express.static('.'))

app.set('view engine', 'pug')

app.get('/', (req, res) => {
    res.render('index', {
        'files': files
    });
})

app.listen(port, () => console.log(`Example app listening on port ${port}!`))

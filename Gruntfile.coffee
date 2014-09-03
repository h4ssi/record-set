module.exports = (grunt) ->
    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'
        haml:
            dist:
                files:
                    'record-set.html': 'record-set.haml'
                    'demo.html': 'demo.haml'
                options:
                    bundleExec: true
    grunt.loadNpmTasks 'grunt-contrib-haml'
    grunt.registerTask 'default', ['haml']

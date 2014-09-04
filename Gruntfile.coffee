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
        copy:
            dev:
                files: [
                        expand: true
                        src: ['*.html']
                        dest: 'bower_components/record-set/'
                ]
        watch:
            dev:
                files: ['*.haml']
                tasks: ['haml','copy']

    grunt.loadNpmTasks 'grunt-contrib-haml'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.registerTask 'default', ['haml']
    grunt.registerTask 'dev', ['haml','copy','watch']

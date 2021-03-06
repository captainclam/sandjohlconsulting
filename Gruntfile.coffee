module.exports = (grunt) ->

  target = grunt.option('target') or 'dev'

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    cssmin:
      combine:
        files:
          'www/main.css': ['www/main.css']

    copy:
      build:
        cwd: 'assets'
        src: ['**/*']
        dest: 'www'
        expand: true
        filter: 'isFile'

    connect:
      server:
        options:
          port: 3000
          useAvailablePort: true
          hostname: '*'
          base: 'www'
          livereload: port: 12345
          # keepalive: true

    'gh-pages':
      options:
        base: 'www'
      src: ['**']

    stylus:
      compile:
        files:
          'www/main.css': 'src/styl/main.styl'

    browserify:
      dist:
        files:
          'www/js/app.js': ['src/coffee/entry.coffee']
        options:
          transform: ['coffeeify']
          extensions: '.coffee'

    jade:
      compile:
        options:
          data:
            DEBUG: target is 'dev'
        files:
          'www/index.html': ['views/index.jade']

    uglify:
      options:
        mangle: false
        nonull: true
        banner: '/*! <%= pkg.name %> <%= grunt.template.today(\'yyyy-mm-dd HH:mm:ss\') %> */\n'
      lib:
        files:
          'www/js/lib.js': [
            'bower_components/lodash/dist/lodash.js'
            'bower_components/jquery/dist/jquery.js'
          ]
      prod:
        src: ['www/js/lib.js', 'www/js/app.js']
        dest: 'www/js/app.min.js'

    autoprefixer:
      options: {}
      no_dest:
        src: 'www/main.css'

    watch:
      stylus:
        files: ['src/styl/**/*.styl']
        tasks: ['stylus']
      browserify:
        files: ['src/coffee/**/*.coffee']
        tasks: ['browserify']
      jade:
        files: ['views/**/*.jade']
        tasks: ['jade']
      livereload:
        options:
          livereload: port: 12345
        files: [
          'www/main.css'
          'www/index.html'
          'www/js/app.js'
        ]

    clean:
      www: ['www']

  grunt.loadNpmTasks 'grunt-autoprefixer'
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-gh-pages'

  grunt.registerTask 'default', ['clean', 'browserify', 'stylus', 'jade', 'uglify', 'autoprefixer', 'copy']
  grunt.registerTask 'server', ['connect', 'watch']
  grunt.registerTask 'dev', ['connect', 'watch']

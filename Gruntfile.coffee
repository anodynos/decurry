module.exports = (grunt) ->
  gruntConfig =
    urequire:
      _all:
        clean: true
        template:
          name: 'nodejs'
          banner: true
        bare: true
        runtimeInfo: false
        debugLevel: 0

      lib:
        path: 'source/code'
        dstPath: 'build/code'

      spec:
        path: 'source/spec'
        dstPath: 'build/spec'
        afterBuild: require('urequire-ab-specrunner').options
          mochaOptions: '--bail'

      specWatch: derive: 'spec', watch: true

  splitTasks = (tasks)-> if (tasks instanceof Array) then tasks else tasks.split(/\s/).filter((f)->!!f)
  grunt.registerTask shortCut, "urequire:#{shortCut}" for shortCut of gruntConfig.urequire
  grunt.registerTask shortCut, splitTasks tasks for shortCut, tasks of {
    default: 'lib spec'
    develop: 'lib specWatch'
  }
  grunt.loadNpmTasks task for task of grunt.file.readJSON('package.json').devDependencies when task.lastIndexOf('grunt-', 0) is 0
  grunt.initConfig gruntConfig

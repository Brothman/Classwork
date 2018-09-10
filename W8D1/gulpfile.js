var gulp = require('gulp');
var browserSync = require('browser-sync').create();

gulp.task('default', runBrowserSync);

function runBrowserSync() {
  browserSync.init({
    proxy: "localhost:3000"
  });

  gulp.watch('app/assets/**/*', browserSync.reload);
  gulp.watch("app/assets/stylesheets/stylee.css", function (event) {
    browserSync.reload("/assets/application.self.css");
  });
}

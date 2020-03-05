const proxy = require('http-proxy-middleware');
module.exports = function(app) {
  app.use(
    '/cgi/genc/tmm_api.pl',
    proxy({
      target: 'https://tennismatchmachine.com',
      changeOrigin: true,
    })
  );
};

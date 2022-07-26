const { createProxyMiddleware } = require('http-proxy-middleware');

module.exports = function (app) {
  app.use(
    '/authority',
    createProxyMiddleware({
      target: 'http://127.0.0.1:3030',
      changeOrigin: true,
      pathRewrite: { '^/authority': '' }
    })
  );
  app.use(
    '/owner',
    createProxyMiddleware({
      target: 'http://127.0.0.1:3035',
      changeOrigin: true,
      pathRewrite: { '^/owner': '' }
    })
  );
  app.use(
    '/purchaser',
    createProxyMiddleware({
      target: 'http://127.0.0.1:3031',
      changeOrigin: true,
      pathRewrite: { '^/purchaser': '' }
    })
  );
};

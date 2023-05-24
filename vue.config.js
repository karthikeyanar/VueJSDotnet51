module.exports = {
    chainWebpack: (config) => {
      // Disable prefetching and preloading
      config.plugins.delete('prefetch')
      config.plugins.delete('preload')
    },
    devServer: {
      proxy: {
        '^/api': {
          target: process.env.VUE_APP_API_PROXY || 'http://localhost:5030',
          ws: true,
          changeOrigin: true
        }
      }
    }
  }
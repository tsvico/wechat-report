module.exports = {
  // 选项...
  publicPath: "./",
  outputDir: "dist",
  productionSourceMap: false, // 生产打包时不输出map文件，增加打包速度
  chainWebpack: config => {
    config
      .plugin('html')
      .tap(args => {
        args[0].title= '杰❤雪雪的 2021 年度聊天报告'
        return args
      })
  }
};

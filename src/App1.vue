<template>
  <div id="app">
      <div v-if="configRule.length > 0 "> 
        <h3 class="sub-title"> 配置数据 </h3>
        <form-create v-model="configValue" v-model:api="fApi" :rule="configRule" :option="configOption"></form-create>
      </div>

      <h3 class="sub-title"> 表单数据 </h3>
      <form-create v-model="uiValue" v-model:api="fApi" :rule="uiRule" :option="uiOption"></form-create>
  </div>
</template>

<script>
import axios from 'axios'

function getQueryVariable(variable)
{
       var query = window.location.search.substring(1);
       var vars = query.split("&");
       for (var i=0;i<vars.length;i++) {
               var pair = vars[i].split("=");
               if(pair[0] == variable){return pair[1];}
       }
       return(false);
}

export default {
    data() {
        return {
            apiUrl: '',
            package: {},
            config: {},
            //实例对象
            fApi: {},
            //表单数据
            uiValue: {},
            //表单生成规则
            uiRule: [
                // {
                //     type: 'input',
                //     field: 'goods_name',
                //     title: '商品名称'
                // }
            ],
            //组件参数配置
            uiOption: {
                //表单提交事件
                onSubmit: function (formData) {
                    alert(JSON.stringify(formData))
                }
            },
            //表单数据
            configValue: {},
            //表单生成规则
            configRule: [
            ],
            //组件参数配置
            configOption: {
                //表单提交事件
                onSubmit:  (formData) => {
                    console.log(this.apiUrl.value, this.uiRule.value)
                    alert(JSON.stringify(formData))
                    axios.post(this.apiUrl.value, formData).then( res=> {
                      if(res.code==200) {
                          alert(res.data)
                      }
                    })
                }
            }
        }
    },
    mounted(){
      const id = getQueryVariable('id')
      let host = getQueryVariable('host')
      if(!host) {
         host = 'http://mytool.zone'
      }
      let url =  host + '/api/v1/tools/' + id
      axios.get(url)
      .then( (response) => {
         var data = response.data
         console.log('res == >', data.data.package)
         if(data.code == 200){
           this.package = data.data.package
           let rule  = JSON.parse(this.package.uiData)
           this.uiRule = rule

           this.config = data.data.config
           let config = JSON.parse(this.package.config)
           this.configRule = config

           this.apiUrl = this.package.apiUrl
         }
      })
      .catch( (error) => {
        console.log(error);
      });
    }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 20px;
}
.sub-title{
  text-align: left;
  margin-left: 0px;
  font-size: 18px;
  font-weight: 500;
}
</style>

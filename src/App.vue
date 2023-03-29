<template>
    <form-create :rule="rule" v-model:api="fApi" :option="options"/>
</template>

<script>
import formCreate from '@form-create/element-ui';
import {createVNode, resolveComponent} from 'vue'
    formCreate.component('inputBtn', {
        data: function () {
            return {
                num: this.modelValue || 0,
            }
        },
        render(){
            return createVNode(resolveComponent('el-button'), {
                disabled: this.disabled,
                long: true,
                onClick:()=>{
                    this.onClick()
                }
            },['计数器'+this.num])
        },
        props:{
            //预定义
            disabled:Boolean,
            modelValue:Number,
        },
        watch:{
            modelValue(n){
                //同步 value 的值
                this.num = n
            }
        },
        methods: {
            onClick: function () {
                this.num++
                //更新组件内部的值
                this.$emit('update:modelValue',this.num)
            },
        },
    })

    export default {
        data(){
            return {
                fApi:{},
                options:{
                    onSubmit:(formData)=>{
                        alert(JSON.stringify(formData))
                    },
                    resetBtn:true
                },
              rule:[
                {
                  type:'inputBtn',
                  field:'btn',
                  title:'自定义表单组件',
                  value:10,
                  update(val, rule, api){
                    api.setValue('input', '' + val);
                  }
                },
                {
                  type:'input',
                  field:'input',
                  title: '修改计数器的值',
                  value: '',
                  children: [
                    {
                      type:'IButton',
                      slot:'addonAfter',
                      inject: true,
                      on: {
                        click(inject){
                          inject.$f.setValue('btn', parseInt(inject.$f.getValue('input')) || 0)
                        }
                      },
                      children: ['修改']
                    }
                  ]
                }
              ]
            }
        }
    }
</script>
import { createApp } from 'vue'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import App from './App.vue'
import formCreate from '@form-create/element-ui'



const app = createApp(App)

app.use(ElementPlus)
app.use(formCreate)
app.mount('#app')




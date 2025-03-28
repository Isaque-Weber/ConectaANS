<template>
    <div>
        <h1>Busca de Operadoras</h1>
        <input type="text" v-model="query" placeholder="Digite o termo de busca..." @keyup.enter="search" />
        <button @click="search">Buscar</button>
        <div v-if="loading">Carregando...</div>
        <div v-if="error">{{ error }}</div>
        <ul>
            <li v-for="(op, index) in results" :key="index">
                <strong>{{ op.nome_fantasia }}</strong> - {{ op.razao_social }}
            </li>
        </ul>
    </div>
</template>

<script>
import axios from "axios";
export default {
    name: "SearchComponent",
    data() {
        return {
            query: "",
            results: [],
            loading: false,
            error: ""
        };
    },
    methods: {
        async search() {
            if (!this.query) {
                this.error = "Por favor, informe um termo de busca.";
                return;
            }
            this.loading = true;
            this.error = "";
            try {
                // Supondo que sua API Flask esteja rodando em http://localhost:5000
                const response = await axios.get("http://localhost:5000/search", {
                    params: { q: this.query }
                });
                this.results = response.data;
            } catch (err) {
                console.error(err);
                this.error = "Erro ao buscar os dados.";
            } finally {
                this.loading = false;
            }
        }
    }
};
</script>

<style scoped>
input {
    margin-right: 10px;
}
</style>

<template>
    <LoadingComponent :props="loading" />

    <div class="col-12">
        <div class="db-card">
            <div class="db-card-header">
                <h3 class="db-card-title">App Color</h3>
            </div>
            <div class="db-card-body">
                <form @submit.prevent="save">
                    <div class="form-row">
                        <div class="form-col-12 sm:form-col-6">
                            <label for="primary_color" class="db-field-title required">Primary Color</label>
                            <div class="flex gap-3 items-center">
                                <input id="primary_color" v-model="form.primary_color" type="color" class="w-16 h-12 rounded border border-gray-200" />
                                <input v-model="form.primary_color" type="text" class="db-field-control" :class="errors.primary_color ? 'invalid' : ''" />
                            </div>
                            <small class="db-field-alert" v-if="errors.primary_color">{{ errors.primary_color[0] }}</small>
                        </div>
                        <div class="form-col-12 sm:form-col-6">
                            <label class="db-field-title after:hidden">Preview</label>
                            <div class="rounded-lg border border-gray-200 p-4 flex items-center gap-4">
                                <div class="w-16 h-16 rounded-full" :style="{ backgroundColor: form.primary_color }"></div>
                                <button class="db-btn py-2 text-white" type="button" :style="{ backgroundColor: form.primary_color }">
                                    Primary Button
                                </button>
                            </div>
                        </div>
                        <div class="form-col-12">
                            <button class="db-btn py-2 text-white bg-primary" type="submit">
                                <i class="lab lab-save"></i>
                                <span>Save</span>
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>

<script>
import axios from "axios";
import LoadingComponent from "../../components/LoadingComponent";
import alertService from "../../../../services/alertService";

export default {
    name: "AppColorComponent",
    components: { LoadingComponent },
    data() {
        return {
            loading: { isActive: false },
            form: { primary_color: "#9FD789" },
            errors: {},
        };
    },
    mounted() {
        this.fetchDesign();
    },
    methods: {
        async fetchDesign() {
            this.loading.isActive = true;
            try {
                const res = await axios.get("admin/app-design");
                this.form.primary_color = res.data.data?.primary_color ?? "#9FD789";
                this.errors = {};
            } catch (error) {
                this.errors = error?.response?.data?.errors ?? {};
            } finally {
                this.loading.isActive = false;
            }
        },
        async save() {
            this.loading.isActive = true;
            try {
                const res = await axios.post("admin/app-design/color", this.form);
                this.form.primary_color = res.data.data?.primary_color ?? this.form.primary_color;
                this.errors = {};
                alertService.successFlip(1, "App Color");
            } catch (error) {
                this.errors = error?.response?.data?.errors ?? {};
            } finally {
                this.loading.isActive = false;
            }
        },
    },
};
</script>

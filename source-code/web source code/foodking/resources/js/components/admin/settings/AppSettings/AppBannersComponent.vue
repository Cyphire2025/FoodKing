<template>
    <LoadingComponent :props="loading" />

    <div class="col-12">
        <div class="db-card">
            <div class="db-card-header">
                <h3 class="db-card-title">Banners</h3>
            </div>
            <div class="db-card-body">
                <form @submit.prevent="save">
                    <div class="form-row">
                        <div class="form-col-12 sm:form-col-6">
                            <label for="banner_1" class="db-field-title">Banner 1</label>
                            <input id="banner_1" ref="bannerOneProperty" type="file" class="db-field-control" :class="errors.banner_1 ? 'invalid' : ''" accept="image/png,image/jpeg,image/jpg,image/gif,image/webp" @change="changeBanner($event, 1)" />
                            <small class="db-field-alert" v-if="errors.banner_1">{{ errors.banner_1[0] }}</small>
                            <div class="rounded-lg border border-gray-200 bg-[#FDF6FB] p-3 mt-3 min-h-[160px] flex items-center justify-center">
                                <img v-if="preview.banner_1" :src="preview.banner_1" class="max-h-[220px] w-full rounded-lg object-contain" alt="Banner 1 preview" />
                                <div v-else class="text-center text-gray-500">No banner 1 uploaded yet.</div>
                            </div>
                        </div>

                        <div class="form-col-12 sm:form-col-6">
                            <label for="banner_2" class="db-field-title">Banner 2</label>
                            <input id="banner_2" ref="bannerTwoProperty" type="file" class="db-field-control" :class="errors.banner_2 ? 'invalid' : ''" accept="image/png,image/jpeg,image/jpg,image/gif,image/webp" @change="changeBanner($event, 2)" />
                            <small class="db-field-alert" v-if="errors.banner_2">{{ errors.banner_2[0] }}</small>
                            <div class="rounded-lg border border-gray-200 bg-[#FDF6FB] p-3 mt-3 min-h-[160px] flex items-center justify-center">
                                <img v-if="preview.banner_2" :src="preview.banner_2" class="max-h-[220px] w-full rounded-lg object-contain" alt="Banner 2 preview" />
                                <div v-else class="text-center text-gray-500">No banner 2 uploaded yet.</div>
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
    name: "AppBannersComponent",
    components: { LoadingComponent },
    data() {
        return {
            loading: { isActive: false },
            files: { banner_1: null, banner_2: null },
            preview: { banner_1: "", banner_2: "" },
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
                this.preview.banner_1 = res.data.data?.banner_1_url ?? "";
                this.preview.banner_2 = res.data.data?.banner_2_url ?? "";
                this.errors = {};
            } catch (error) {
                this.errors = error?.response?.data?.errors ?? {};
            } finally {
                this.loading.isActive = false;
            }
        },
        changeBanner(e, number) {
            const file = e.target.files[0];
            const key = number === 1 ? "banner_1" : "banner_2";
            this.files[key] = file;
            if (file) {
                this.preview[key] = URL.createObjectURL(file);
            }
        },
        async save() {
            const fd = new FormData();
            if (this.files.banner_1) {
                fd.append("banner_1", this.files.banner_1);
            }
            if (this.files.banner_2) {
                fd.append("banner_2", this.files.banner_2);
            }

            this.loading.isActive = true;
            try {
                const res = await axios.post("admin/app-design/banners", fd);
                this.preview.banner_1 = res.data.data?.banner_1_url ?? this.preview.banner_1;
                this.preview.banner_2 = res.data.data?.banner_2_url ?? this.preview.banner_2;
                this.files.banner_1 = null;
                this.files.banner_2 = null;
                this.errors = {};
                if (this.$refs.bannerOneProperty) this.$refs.bannerOneProperty.value = null;
                if (this.$refs.bannerTwoProperty) this.$refs.bannerTwoProperty.value = null;
                alertService.successFlip(1, "Banners");
            } catch (error) {
                this.errors = error?.response?.data?.errors ?? {};
            } finally {
                this.loading.isActive = false;
            }
        },
    },
};
</script>

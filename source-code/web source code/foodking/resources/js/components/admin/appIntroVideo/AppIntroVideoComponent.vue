<template>
    <LoadingComponent :props="loading" />

    <div class="col-12">
        <div class="db-card">
            <div class="db-card-header">
                <h3 class="db-card-title">App Intro Video</h3>
            </div>
            <div class="db-card-body">
                <form @submit.prevent="save">
                    <div class="form-row">
                        <div class="form-col-12 sm:form-col-6">
                            <label for="app_intro_media" class="db-field-title required">
                                Upload Video or Image
                            </label>
                            <input
                                id="app_intro_media"
                                ref="appIntroMediaProperty"
                                type="file"
                                class="db-field-control"
                                :class="errors.app_intro_media ? 'invalid' : ''"
                                accept="image/png,image/jpeg,image/jpg,image/gif,image/webp,video/mp4,video/quicktime,video/webm,video/x-msvideo,video/x-matroska"
                                @change="changeMedia"
                            />
                            <small class="db-field-alert" v-if="errors.app_intro_media">
                                {{ errors.app_intro_media[0] }}
                            </small>
                            <p class="text-sm text-gray-500 mt-2">
                                Supported: JPG, PNG, GIF, WEBP, MP4, MOV, WEBM, AVI, MKV. Max 50MB.
                            </p>
                        </div>

                        <div class="form-col-12 sm:form-col-6">
                            <label class="db-field-title after:hidden">Current Preview</label>
                            <div class="rounded-lg border border-gray-200 bg-[#FDF6FB] p-3 min-h-[220px] flex items-center justify-center">
                                <video
                                    v-if="previewUrl && previewType === 'video'"
                                    class="max-h-[260px] w-full rounded-lg object-contain bg-black"
                                    :src="previewUrl"
                                    controls
                                ></video>
                                <img
                                    v-else-if="previewUrl"
                                    class="max-h-[260px] w-full rounded-lg object-contain"
                                    :src="previewUrl"
                                    alt="App intro preview"
                                />
                                <div v-else class="text-center text-gray-500">
                                    No app intro media uploaded yet.
                                </div>
                            </div>
                        </div>

                        <div class="form-col-12">
                            <div class="flex flex-wrap gap-3 mt-2">
                                <button class="db-btn py-2 text-white bg-primary" type="submit">
                                    <i class="lab lab-save"></i>
                                    <span>Save</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>

<script>
import axios from "axios";
import LoadingComponent from "../components/LoadingComponent";
import alertService from "../../../services/alertService";

export default {
    name: "AppIntroVideoComponent",
    components: { LoadingComponent },
    data() {
        return {
            loading: { isActive: false },
            media: null,
            previewUrl: "",
            previewType: "",
            errors: {},
        };
    },
    mounted() {
        this.fetchMedia();
    },
    methods: {
        async fetchMedia() {
            this.loading.isActive = true;
            try {
                const res = await axios.get("admin/app-intro-video");
                const data = res.data.data ?? {};
                this.previewUrl = data.media_url ?? "";
                this.previewType = data.media_type ?? "";
                this.errors = {};
            } catch (error) {
                this.errors = error?.response?.data?.errors ?? {};
            } finally {
                this.loading.isActive = false;
            }
        },
        changeMedia(e) {
            const file = e.target.files[0];
            this.media = file;
            if (!file) {
                return;
            }
            this.previewUrl = URL.createObjectURL(file);
            this.previewType = file.type.startsWith("image/") ? "image" : "video";
        },
        async save() {
            if (!this.media) {
                this.errors = { app_intro_media: ["Please choose a video or image first."] };
                return;
            }

            const fd = new FormData();
            fd.append("app_intro_media", this.media);

            this.loading.isActive = true;
            try {
                const res = await axios.post("admin/app-intro-video", fd);
                const data = res.data.data ?? {};
                this.previewUrl = data.media_url ?? "";
                this.previewType = data.media_type ?? "";
                this.media = null;
                this.errors = {};
                this.$refs.appIntroMediaProperty.value = null;
                alertService.successFlip(1, "App Intro Video");
            } catch (error) {
                this.errors = error?.response?.data?.errors ?? {};
            } finally {
                this.loading.isActive = false;
            }
        },
    },
};
</script>

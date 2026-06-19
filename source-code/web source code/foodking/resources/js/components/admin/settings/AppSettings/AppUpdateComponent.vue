<template>
    <LoadingComponent :props="loading" />

    <div class="col-12">
        <div class="db-card mb-6">
            <div class="db-card-header">
                <h3 class="db-card-title">{{ editingId ? "Edit Update" : "Add Update" }}</h3>
            </div>
            <div class="db-card-body">
                <form @submit.prevent="save">
                    <div class="form-row">
                        <div class="form-col-12 sm:form-col-6">
                            <label for="image" class="db-field-title">Image</label>
                            <input
                                id="image"
                                ref="imageProperty"
                                type="file"
                                class="db-field-control"
                                :class="errors.image ? 'invalid' : ''"
                                accept="image/png,image/jpeg,image/jpg,image/gif,image/webp"
                                @change="changeImage"
                            />
                            <small class="db-field-alert" v-if="errors.image">{{ errors.image[0] }}</small>
                        </div>

                        <div class="form-col-12 sm:form-col-6">
                            <label class="db-field-title after:hidden">Preview</label>
                            <div class="rounded-lg border border-gray-200 bg-[#FDF6FB] p-3 min-h-[180px] flex items-center justify-center">
                                <img
                                    v-if="previewUrl"
                                    class="max-h-[220px] w-full rounded-lg object-contain"
                                    :src="previewUrl"
                                    alt="Update preview"
                                />
                                <div v-else class="text-center text-gray-500">No update image selected.</div>
                            </div>
                        </div>

                        <div class="form-col-12">
                            <label for="heading" class="db-field-title">Heading</label>
                            <input id="heading" v-model="form.heading" type="text" class="db-field-control" :class="errors.heading ? 'invalid' : ''" />
                            <small class="db-field-alert" v-if="errors.heading">{{ errors.heading[0] }}</small>
                        </div>

                        <div class="form-col-12">
                            <label for="description" class="db-field-title">Description</label>
                            <textarea id="description" v-model="form.description" class="db-field-control" :class="errors.description ? 'invalid' : ''" rows="5"></textarea>
                            <small class="db-field-alert" v-if="errors.description">{{ errors.description[0] }}</small>
                        </div>

                        <div class="form-col-12 sm:form-col-6">
                            <div class="rounded-lg border border-gray-200 p-4">
                                <label class="flex items-center gap-3 mb-4">
                                    <input v-model="form.button_one_enabled" type="checkbox" />
                                    <span class="db-field-title after:hidden mb-0">Button 1 Enabled</span>
                                </label>
                                <label for="button_one_text" class="db-field-title">Button 1 Text</label>
                                <input id="button_one_text" v-model="form.button_one_text" type="text" class="db-field-control" />
                                <small class="db-field-alert" v-if="errors.button_one_text">{{ errors.button_one_text[0] }}</small>

                                <label for="button_one_link" class="db-field-title mt-4">Button 1 Link</label>
                                <input id="button_one_link" v-model="form.button_one_link" type="url" class="db-field-control" />
                                <small class="db-field-alert" v-if="errors.button_one_link">{{ errors.button_one_link[0] }}</small>
                            </div>
                        </div>

                        <div class="form-col-12 sm:form-col-6">
                            <div class="rounded-lg border border-gray-200 p-4">
                                <label class="flex items-center gap-3 mb-4">
                                    <input v-model="form.button_two_enabled" type="checkbox" />
                                    <span class="db-field-title after:hidden mb-0">Button 2 Enabled</span>
                                </label>
                                <label for="button_two_text" class="db-field-title">Button 2 Text</label>
                                <input id="button_two_text" v-model="form.button_two_text" type="text" class="db-field-control" />
                                <small class="db-field-alert" v-if="errors.button_two_text">{{ errors.button_two_text[0] }}</small>

                                <label for="button_two_link" class="db-field-title mt-4">Button 2 Link</label>
                                <input id="button_two_link" v-model="form.button_two_link" type="url" class="db-field-control" />
                                <small class="db-field-alert" v-if="errors.button_two_link">{{ errors.button_two_link[0] }}</small>
                            </div>
                        </div>

                        <div class="form-col-12">
                            <div class="flex flex-wrap gap-3">
                                <button class="db-btn py-2 text-white bg-primary" type="submit">
                                    <i class="lab lab-save"></i>
                                    <span>{{ editingId ? "Update" : "Save" }}</span>
                                </button>
                                <button v-if="editingId" class="db-btn py-2 text-primary bg-[#F8ECF4]" type="button" @click="resetForm">
                                    Cancel Edit
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="db-card">
            <div class="db-card-header">
                <h3 class="db-card-title">All Updates</h3>
            </div>
            <div class="db-card-body">
                <div v-if="updates.length === 0" class="text-center text-gray-500 py-8">No updates added yet.</div>
                <div v-else class="grid grid-cols-1 lg:grid-cols-2 gap-4">
                    <div v-for="update in updates" :key="update.id" class="rounded-lg border border-gray-200 overflow-hidden bg-white">
                        <img v-if="update.image_url" :src="update.image_url" class="w-full h-44 object-cover" alt="Update image" />
                        <div class="p-4">
                            <h4 class="font-semibold text-heading text-lg mb-2">{{ update.heading || "Untitled update" }}</h4>
                            <p class="text-sm text-gray-500 mb-4 whitespace-pre-line">{{ update.description }}</p>
                            <div class="flex flex-wrap gap-2 mb-4">
                                <span v-if="update.button_one_enabled" class="px-3 py-1 rounded-full bg-[#F8ECF4] text-primary text-sm">
                                    {{ update.button_one_text || "Button 1" }}
                                </span>
                                <span v-if="update.button_two_enabled" class="px-3 py-1 rounded-full bg-[#F8ECF4] text-primary text-sm">
                                    {{ update.button_two_text || "Button 2" }}
                                </span>
                            </div>
                            <div class="flex gap-2">
                                <button class="db-btn py-2 text-white bg-primary" type="button" @click="editUpdate(update)">Edit</button>
                                <button class="db-btn py-2 text-white bg-red-500" type="button" @click="deleteUpdate(update.id)">Delete</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import axios from "axios";
import LoadingComponent from "../../components/LoadingComponent";
import alertService from "../../../../services/alertService";

const emptyForm = () => ({
    heading: "",
    description: "",
    button_one_enabled: false,
    button_one_text: "",
    button_one_link: "",
    button_two_enabled: false,
    button_two_text: "",
    button_two_link: "",
});

export default {
    name: "AppUpdateComponent",
    components: { LoadingComponent },
    data() {
        return {
            loading: { isActive: false },
            updates: [],
            editingId: null,
            image: null,
            previewUrl: "",
            form: emptyForm(),
            errors: {},
        };
    },
    mounted() {
        this.fetchUpdates();
    },
    methods: {
        async fetchUpdates() {
            this.loading.isActive = true;
            try {
                const res = await axios.get("admin/app-update");
                this.updates = res.data.data ?? [];
                this.errors = {};
            } catch (error) {
                this.errors = error?.response?.data?.errors ?? {};
            } finally {
                this.loading.isActive = false;
            }
        },
        editUpdate(update) {
            this.editingId = update.id;
            this.previewUrl = update.image_url ?? "";
            this.form = {
                heading: update.heading ?? "",
                description: update.description ?? "",
                button_one_enabled: !!update.button_one_enabled,
                button_one_text: update.button_one_text ?? "",
                button_one_link: update.button_one_link ?? "",
                button_two_enabled: !!update.button_two_enabled,
                button_two_text: update.button_two_text ?? "",
                button_two_link: update.button_two_link ?? "",
            };
            this.image = null;
            this.errors = {};
            if (this.$refs.imageProperty) {
                this.$refs.imageProperty.value = null;
            }
        },
        changeImage(e) {
            const file = e.target.files[0];
            this.image = file;
            if (file) {
                this.previewUrl = URL.createObjectURL(file);
            }
        },
        formData() {
            const fd = new FormData();
            Object.entries(this.form).forEach(([key, value]) => {
                fd.append(key, typeof value === "boolean" ? (value ? 1 : 0) : value);
            });
            if (this.image) {
                fd.append("image", this.image);
            }
            return fd;
        },
        async save() {
            this.loading.isActive = true;
            try {
                if (this.editingId) {
                    await axios.post(`admin/app-update/${this.editingId}`, this.formData());
                } else {
                    await axios.post("admin/app-update", this.formData());
                }
                await this.fetchUpdates();
                this.resetForm();
                alertService.successFlip(1, "Updates");
            } catch (error) {
                this.errors = error?.response?.data?.errors ?? {};
            } finally {
                this.loading.isActive = false;
            }
        },
        async deleteUpdate(id) {
            if (!confirm("Delete this update?")) {
                return;
            }
            this.loading.isActive = true;
            try {
                await axios.delete(`admin/app-update/${id}`);
                await this.fetchUpdates();
                if (this.editingId === id) {
                    this.resetForm();
                }
                alertService.successFlip(null, "Updates");
            } catch (error) {
                this.errors = error?.response?.data?.errors ?? {};
            } finally {
                this.loading.isActive = false;
            }
        },
        resetForm() {
            this.editingId = null;
            this.image = null;
            this.previewUrl = "";
            this.form = emptyForm();
            this.errors = {};
            if (this.$refs.imageProperty) {
                this.$refs.imageProperty.value = null;
            }
        },
    },
};
</script>

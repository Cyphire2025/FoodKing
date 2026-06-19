<template>
    <LoadingComponent :props="loading" />

    <div class="col-12">
        <div class="db-card">
            <div class="db-card-header">
                <h3 class="db-card-title">Today's Special</h3>
            </div>
            <div class="db-card-body">
                <form @submit.prevent="save">
                    <div class="form-row">
                        <div class="form-col-12 sm:form-col-8">
                            <label for="today_special_item" class="db-field-title required">Select Item</label>
                            <vue-select
                                id="today_special_item"
                                class="db-field-control f-b-custom-select"
                                v-model="form.item_id"
                                :options="items"
                                label-by="name"
                                value-by="id"
                                :closeOnSelect="true"
                                :searchable="true"
                                :clearOnClose="true"
                                placeholder="--"
                                search-placeholder="Search item"
                            />
                            <small class="db-field-alert" v-if="errors.item_id">{{ errors.item_id[0] }}</small>
                        </div>

                        <div class="form-col-12 sm:form-col-4" v-if="selectedItem">
                            <label class="db-field-title after:hidden">Current Selection</label>
                            <div class="rounded-lg border border-gray-200 p-3">
                                <div class="font-medium text-heading">{{ selectedItem.name }}</div>
                                <div class="text-sm text-gray-500">{{ selectedItem.category_name }}</div>
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
    name: "TodaySpecialComponent",
    components: { LoadingComponent },
    data() {
        return {
            loading: { isActive: false },
            form: {
                item_id: null,
            },
            items: [],
            selectedItem: null,
            errors: {},
        };
    },
    mounted() {
        this.fetchItems();
        this.fetchSelected();
    },
    methods: {
        async fetchItems() {
            try {
                const res = await axios.get("admin/item", {
                    params: { paginate: 0, status: 5 },
                });
                this.items = res.data.data ?? [];
            } catch (error) {
                this.items = [];
            }
        },
        async fetchSelected() {
            this.loading.isActive = true;
            try {
                const res = await axios.get("admin/today-special");
                const data = res.data.data ?? {};
                this.form.item_id = data.item_id;
                this.selectedItem = data.item;
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
                const res = await axios.put("admin/today-special", this.form);
                this.form.item_id = res.data.data.item_id;
                this.selectedItem = res.data.data.item;
                this.errors = {};
                alertService.successFlip(1, "Today's Special");
            } catch (error) {
                this.errors = error?.response?.data?.errors ?? {};
            } finally {
                this.loading.isActive = false;
            }
        },
    },
};
</script>
